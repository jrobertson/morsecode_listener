#!/usr/bin/env ruby

# file: morsecode_listener.rb

class MorseCodeListener

  def initialize(short_delay: 0.35, long_delay: 1, dot: 2, dash: 1, 
        separator: 4, space: 5, timeout: 2, notifier: nil, &on_message)

    @short_delay, @long_delay, @timeout = short_delay, long_delay, timeout
    @h = { dot: dot, dash: dash, separator: separator, space: space }
    @notifier, @on_message = notifier, on_message
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
      @a.pop
      @a << @h[:space]
      sleep @timeout - @long_delay - @short_delay
      @a.pop

      s = @a.join

      if @notifier then

        begin
          @notifier.message s if @notifier.respond_to? :message
        rescue
          puts 'warning: MorseCodeListener#on_keyup @notifier' + ($!).inspect
        end
        
      elsif @on_message
        
        @on_message.call s

      else
        puts '>> ' + s
      end

      @a = []

    end

  end
end