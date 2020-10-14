# -*- encoding: utf-8 -*-
# stub: pager_api 0.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "pager_api".freeze
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Abraham Kuri".freeze]
  s.bindir = "exe".freeze
  s.date = "2019-06-10"
  s.description = "A super simple yet powerful gem to respond with paginated collections using the JSON API standard".freeze
  s.email = ["kurenn@icalialabs.com".freeze]
  s.homepage = "https://github.com/IcaliaLabs/pager-api".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "A Rails pagination JSON handler, perfect for API".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_development_dependency(%q<bundler>.freeze, ["~> 1.9"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.9"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
