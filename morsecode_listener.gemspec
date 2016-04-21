Gem::Specification.new do |s|
  s.name = 'morsecode_listener'
  s.version = '0.1.3'
  s.summary = 'Use in conjunction with an event driven application to listen for a morse code message.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/morsecode_listener.rb']
  s.signing_key = '../privatekeys/morsecode_listener.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/morsecode_listener'
end
