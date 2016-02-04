#!/usr/bin/env ruby

# file: morsecode_listener.rb

class MorseCodeListener

  def initialize(short_delay: 0.35, long_delay: 1, dot: 2, dash: 1, 
        separator: 4, timeout: 2, notifier: nil)

    @short_delay, @long_delay, @timeout = short_delay, long_delay, timeout
    @h = { dot: dot, dash: dash, separator: separator }
    @notifier = notifier
    @t, @a = nil, []
  end

  def on_keydown()

    @thread.exit if @thread
    @t = Time.now
  end

  def on_keyup()

    t = Time.now - @t

    if t < @short_delay then
      @a << @h[:dot]
    elsif t < @long_delay
      @a << @h[:dash]      
    end

    
    @thread = Thread.new do

      sleep @short_delay * 2
      @a << @h[:separator]
      sleep @long_delay - @short_delay
      @a << @h[:separator]
      sleep @timeout - @long_delay - @short_delay
      @a.pop 2

      s = @a.join

      if @notifier then

        begin
          @notifier.message s
        rescue
          puts 'warning: MorseCodeListener#on_keyup @notifier' + ($!).inspect
        end

      else
        puts '>> ' + s
      end

      @a = []

    end

  end
end