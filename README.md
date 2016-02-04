# Introducing the Morsecode_listener gem

    #!/usr/bin/env ruby

    # file: keypress_event.rb

    require 'gtk2'
    require 'morsecode'
    require 'gtk2keypress'
    require 'morsecode_listener' 


    class MorseCodeTranslator < MorseCode

      def message(s)
        @input_string = s
        puts '>> ' + self.to_s
      end
    end

    mct = MorseCodeTranslator.new
    mcl = MorseCodeListener.new notifier: mct

    window = Gtk::Window.new
    window.add(Gtk::Label.new("Press Key!"))

    key = Gtk2KeyPress.new window, mcl

    def key.on_keypress(e)
      puts 'key press ' + e.name
    end

    window.set_default_size(100, 100).show_all

    Gtk.main

The above code demonstrates listening for key presses which are tapped out as Morse code, and is then translated to plain English.

It uses timing to differentiate between a dot, a dash, a separator, and a word.  The default timings are as follows:

* dot: < 0.35 second
* dash: < 1 second
* separator: <= 0.7 second
* word separator: 1.35 seconds

## Resources

* Introducing the GTK2KeyPress gem http://www.jamesrobertson.eu/snippets/2016/feb/04/introducing-the-gtk2keypress-gem.html
* Introducing the Morsecode gem http://www.jamesrobertson.eu/snippets/2013/feb/07/introducing-the-morsecode-gem.html

morsecode keypress gtk2
