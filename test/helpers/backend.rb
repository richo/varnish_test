#!/usr/bin/env ruby
#
#
require 'thread'
require 'socket'

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
        client = serv.accept
        lines = []
        while (line = client.gets) != "\r\n"
          lines << line
        end
        de_q.enq(lines.join("\r\n"))

        # XXX Doesn't complain if nothing is queued
        client.puts(in_q.deq)

        client.close
      end
    end
  end

end

# Seed the queue by giving it a port
SingletonQueue.new(port: 2000)
