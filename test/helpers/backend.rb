#!/usr/bin/env ruby
#
#
require 'thread'
require 'socket'
require File.expand_path("../thin_http_parser", __FILE__)

class SingletonQueue

  def self.new(*args)
    # Guarantees that only a single instance will exist
    @@instance ||= super(*args)
  end

  def self.get
    # Helper to make what's going on more obvious
    @@instance
  end

######

  def initialize(opts={})
    @in_q  = Queue.new
    @out_q = Queue.new
    spawn_reader(opts[:port])
  end
  attr_reader :in_q, :out_q

  def enq(data)
    in_q.enq(data)
  end

  def deq
    out_q.deq
  end

private

  def spawn_reader(port)
    Thread.new(in_q, out_q) do |en_q, de_q|
      serv = TCPServer.new port
      loop do
        # Create a parser object
        parser = RequestParser.new

        # Pop a connection off the stack
        client = serv.accept

        # retrieve the headers
        lines = []
        while (line = client.gets) != "\r\n"
          # XXX Hack around missing CONTENT_LENGTH in parser.env
          if parser.env['CONTENT_LENGTH'].nil? && line =~ /^Content-Length: (\d+)/
            parser.env['CONTENT_LENGTH'] = $1.to_i
          end
          lines << line
        end

        parser.parse(lines.join("\r\n"))

        if parser.content_length > 0
          parser.parse(client.gets(parser.content_length))
        end

        de_q.enq(parser)

        client.close
      end
    end
  end

end

# Seed the queue by giving it a port
SingletonQueue.new(port: 2000)
