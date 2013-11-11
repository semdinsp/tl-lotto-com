require 'i18n'
require 'i18n/backend/fallbacks'
#puts "root is #{settings.root}"
module Nesta
  class App
    not_found do
      cache haml("404".to_sym)
    end
     configure do
        I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
        I18n.load_path=Dir[File.join(settings.root, 'config/locales', '*.yml')]
        I18n.backend.load_translations
        I18n.locale = 'en'
      end
  end
  class Page
    def heading
        regex = case @format
          when :mdown
            /^#\s*(.*?)(\s*#+|$)/
          when :haml
            /^\s*%h1\s+(.*)/
          when :textile
            /^\s*h1\.\s+(.*)/
          end
        markup =~ regex
        val=Regexp.last_match(1) or raise HeadingNotSet, "#{abspath} needs a heading"
        #puts "val is [#{val}]"
        val=eval(val[1..val.size]) if val[0]=='='
        val
      end
    end
end

