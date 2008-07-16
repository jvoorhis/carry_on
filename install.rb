require 'fileutils'

gem_dir = File.join(RAILS_ROOT, 'vendor/gems')
FileUtils.mkdir(gem_dir) unless File.exist?(gem_dir)

gem_src  = File.join(File.dirname(__FILE__), 'scripts/gem')
gem_dest = File.join(RAILS_ROOT, 'script/gem')
FileUtils.cp(gem_src, gem_dest)
FileUtils.chmod(0755, gem_dest)
