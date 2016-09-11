Pod::Spec.new do |s|
  s.name             = "Gloss"
  s.version          = "0.7.5"
  s.summary          = "A shiny JSON parsing library in Swift"
  s.description      = "A shiny JSON parsing library in Swift. Features include mapping JSON to objects, mapping objects to JSON, handling of nested objects and custom transformations."
  s.homepage         = "https://github.com/hkellaway/Gloss"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Harlan Kellaway" => "hello@harlankellaway.com" }
  s.social_media_url = "http://twitter.com/HarlanKellaway"
  s.source           = { :git => "https://github.com/SmartTechCom/Gloss.git", :tag => s.version.to_s }
  
  s.platforms     = { :ios => "8.0", :osx => "10.9", :tvos => "9.0", :watchos => "2.0" }
  s.requires_arc = true

  if ENV['IS_SOURCE']
     puts '-------------------------------------'
     puts 'Notice: Gloss Component is source now'
     puts '-------------------------------------'
     s.source_files     = 'Sources/*.{swift}'
  else
     puts '----------------------------------------'
     puts 'Notice: Gloss Component is framework now'
     puts '----------------------------------------'
     s.vendored_frameworks = 'Products/Gloss.framework'
  end

end
