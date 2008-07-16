require 'rbconfig'
require 'rubygems'
require 'fileutils'

module CarryOn
  
  module_function
  # +CarryOn+'s canonical name for the current architecture/OS.
  def canonical_arch
    Config::CONFIG['arch'].sub(/[\.0-9]*$/, '')
  end
  
  # The path to architecture-neutral gems installed by +CarryOn+.
  def ruby_spec_path
    File.join(RAILS_ROOT, 'vendor/gems/ruby/specifications')
  end
  
  # The path to architecture-dependent gems installed by +CarryOn+.
  def arch_spec_path
    File.join(RAILS_ROOT, 'vendor/gems', canonical_arch, 'specifications')
  end
  
  # Add the load path for the current architecture. E.g., on an Intel Mac, gems
  # will be loaded from +vendor/gems/i686-darwin/+.
  def add_to_load_path
    Gem.source_index.load_gems_in(*Gem::SourceIndex.installed_spec_directories | [ruby_spec_path, arch_spec_path])
  end
  
  # Install a gem into the vendor directory. Requires a path to a .gem file for its first parameter.
  def install_gem(gem)
    Gem.manage_gems
    installer = Gem::Installer.new(gem)
    format = Gem::Format.from_file_by_path(gem)
    dir = File.join(RAILS_ROOT, 'vendor', 'gems',
                    format.spec.extensions.empty? ? 'ruby' : canonical_arch)
    FileUtils.mkdir_p(dir)
    installer.install(false, dir)
  end
end
