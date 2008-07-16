require File.join(File.dirname(__FILE__), '../carry_on')

module CarryOn # :nodoc:
  module Commands # :nodoc:
    
    module_function
    
    def dispatch(args)
      case args.first
        when 'install'
          args.shift
          while gem = args.shift
            CarryOn::install_gem(gem)
          end
        else
          display_help
      end
    end
        
    def display_help
      puts
      puts "Usage: ./script/gem install [gems]"
      puts
    end
    
  end
end

args = !ARGV.include?("--") ? ARGV.clone : ARGV[0...ARGV.index("--")]
CarryOn::Commands::dispatch(args)
