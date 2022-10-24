# frozen_string_literal: false

require 'loquacious'

# rubocop:disable Style/MixinUsage
include Loquacious
# rubocop:enable Style/MixinUsage

RSpec.describe 'Sample::Usage::Loquacious' do
  describe "FrozenError: can't modify frozen String: xyz" do
    # if you receive a FrozenError then you probably have
    # frozen_string_literal: true
    # in your file, this GEM has issues with this, so change to
    # frozen_string_literal: false
  end

  def line
    puts '----------------------------------------------------------------------'
  end

  def show(key)
    line
    Configuration.help_for(key).show values: true
    line
  end

  describe '#configuration' do
    it 'configures options (a b c)' do
      Configuration.for(:key_values) do
        a "value for 'a'"
        b 'William Shakespeare'
        c 42
      end

      show :key_values
    end

    it 'configure options with descriptions' do
      Configuration.for(:key_value_descriptions) do
        desc 'Your first configuration option'
        a "value for 'a'"

        desc 'To be or not to be'
        b 'William Shakespeare'

        desc 'The underpinnings of Ruby'
        c 42
      end

      show :key_value_descriptions
    end

    it 'configure options with inline descriptions' do
      Configuration.for(:inline_descriptions) do
        name 'value', desc: 'Defines the name'
        foo  'bar',   desc: 'FooBar'
        id   42,      desc: 'Ara T. Howard'
      end

      show :inline_descriptions
      # help = Configuration.help_for :inline_descriptions
      # puts '----------------------------------------------------------------------'
      # help.show values: true
      # puts '----------------------------------------------------------------------'
    end

    it 'configure nested settings' do
      Configuration.for(:nested) do
        desc 'The outermost level'
        a do
          desc 'One more level in'
          b do
            desc 'Finally, a real value'
            c1 'value'

            desc 'And another real value'
            c2 'value'
          end
          b2 'Value for B2'
          b3 'Value for B3'
        end
      end

      show :nested
    end

    it 'complex configuration settings' do
      Configuration.for(:complex) do
        root_path '.', desc: "The application's base directory."

        desc 'Configuration options for ActiveRecord::Base.'
        active_record do
          colorize_logging true, desc: <<-__
            Determines whether to use ANSI codes to colorize the logging statements committed
            by the connection adapter. These colors make it much easier to overview things
            during debugging (when used through a reader like +tail+ and on a black background),
            but may complicate matters if you use software like syslog. This is true, by default.
          __

          default_timezone :local, desc: <<-__
            Determines whether to use Time.local (using :local) or Time.utc (using :utc)
            when pulling dates and times from the database. This is set to :local by default.
          __
        end

        log_level :info, desc: <<-__
          The log level to use for the default Rails logger. In production mode,
          this defaults to :info. In development mode, it defaults to :debug.
        __

        log_path 'log/development.log', desc: <<-__
          The path to the log file to use. Defaults to log/\#{environment}.log
          (e.g. log/development.log or log/production.log).
        __
      end

      show :complex
    end
  end

  context 'read configuration option' do
    let(:config) do
      Configuration.for(:key_values) do
        a "value for 'a'"
        b 'William Shakespeare'
        c 42
      end
    end

    it 'read valid options' do
      line
      puts config.a
      puts config.b
      puts config.c
      line
    end

    it 'handle invalid option calls gracefully <Loquacious::Undefined>' do
      line
      # rubocop:disable Style/RedundantInterpolation
      puts "#{config.bad}"
      # rubocop:enable Style/RedundantInterpolation
      line
    end
  end
end
