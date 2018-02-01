# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: agent_zmq 0.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "agent_zmq"
  s.version = "0.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Chris Busbey"]
  s.date = "2016-09-01"
  s.description = "Acceptance test framework for ZeroMQ applications. Includes some cucumber helpers."
  s.email = "info@connamara.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".travis.yml",
    "CONTRIBUTION_GUIDELINES.md",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "agent_zmq.gemspec",
    "config/zmq_agents.rb",
    "features/memory.feature",
    "features/message_inspection.feature",
    "features/send_and_receive.feature",
    "features/support/env.rb",
    "lib/agent_zmq.rb",
    "lib/agent_zmq/agent.rb",
    "lib/agent_zmq/agents/base_agent.rb",
    "lib/agent_zmq/agents/dealer_agent.rb",
    "lib/agent_zmq/agents/pub_agent.rb",
    "lib/agent_zmq/agents/rep_agent.rb",
    "lib/agent_zmq/agents/req_agent.rb",
    "lib/agent_zmq/agents/sub_agent.rb",
    "lib/agent_zmq/configuration.rb",
    "lib/agent_zmq/cucumber.rb",
    "lib/agent_zmq/helpers.rb",
    "lib/agent_zmq/message_cache.rb",
    "spec/agent_zmq/configuration_spec.rb",
    "spec/agent_zmq/message_cache_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "https://github.com/connamara/agent_zmq"
  s.licenses = ["GPL"]
  s.rubygems_version = "2.4.3"
  s.summary = "Acceptance test framework for ZeroMQ applications"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ffi-rzmq>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8"])
      s.add_development_dependency(%q<rake>, ["~> 10.1"])
      s.add_development_dependency(%q<rspec>, ["~> 2.14"])
      s.add_development_dependency(%q<anticipate>, ["~> 0.1.1"])
      s.add_development_dependency(%q<cucumber>, ["~> 1.3"])
      s.add_development_dependency(%q<cuke_mem>, ["~> 0.1.1"])
      s.add_development_dependency(%q<rack>, ["~> 1.5"])
    else
      s.add_dependency(%q<ffi-rzmq>, [">= 0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8"])
      s.add_dependency(%q<rake>, ["~> 10.1"])
      s.add_dependency(%q<rspec>, ["~> 2.14"])
      s.add_dependency(%q<anticipate>, ["~> 0.1.1"])
      s.add_dependency(%q<cucumber>, ["~> 1.3"])
      s.add_dependency(%q<cuke_mem>, ["~> 0.1.1"])
      s.add_dependency(%q<rack>, ["~> 1.5"])
    end
  else
    s.add_dependency(%q<ffi-rzmq>, [">= 0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8"])
    s.add_dependency(%q<rake>, ["~> 10.1"])
    s.add_dependency(%q<rspec>, ["~> 2.14"])
    s.add_dependency(%q<anticipate>, ["~> 0.1.1"])
    s.add_dependency(%q<cucumber>, ["~> 1.3"])
    s.add_dependency(%q<cuke_mem>, ["~> 0.1.1"])
    s.add_dependency(%q<rack>, ["~> 1.5"])
  end
end

