require "bundler/setup"
require 'test/unit'
require 'rubygems'
#gem 'rack-test'
require 'rack/test'
require 'nesta/env'
Nesta::Env.root = ::File.expand_path('.', ::File.dirname(__FILE__))

require 'nesta/app'

ENV['RACK_ENV'] = 'test'

class FiconabTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Nesta::App
  end

  def test_first_pageworks
    get '/'
    #puts last_response.methods
    assert last_response.ok?
    assert last_response.body.include? 'Ficonab Pte. Ltd.'
  end

  def test_key_pages
     
     pagelist=["contact","about","technotes","strategies","strategies/value", "/"]
     puts "testing top level pages #{pagelist.inspect}"
     pagelist.each { |page| 
          get page
          assert last_response.ok?, "#{page} not found"
          #assert_equal last_response.body.includes? 'Ficonab Pte. Ltd.'
            }
   end
   def test_technotes_pages
      pagelist=["bootstrapv3","coffeescript","resque","sendmail", "heroku","postgres", "postgres", "bunny-amqp","email-authentication"]
      puts "testing tech note pages #{pagelist.inspect}"
      pagelist.each { |page| 
           get "technotes/#{page}"
           assert last_response.ok?, "technotes/#{page} not found"
           #assert_equal last_response.body.includes? 'Ficonab Pte. Ltd.'
             }
    end
    def test_strategies_pages
        pagelist=["geographic","value","lumpy_streams"]
        puts "testing strategy pages #{pagelist.inspect}"
        pagelist.each { |page| 
             get "strategies/#{page}"
             assert last_response.ok?, "strategies/#{page} not found"
             #assert_equal last_response.body.includes? 'Ficonab Pte. Ltd.'
               }
      end
  
end