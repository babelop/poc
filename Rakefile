require 'rake/clean'
require 'archive/tar/minitar'
require 'rbconfig'

CLEAN.include('build/*')
CLEAN.exclude('build/*.tar')
CLOBBER.include('build/*')

basepath = File::dirname(__FILE__)

unless RbConfig::CONFIG['host_os'] =~ /darwin|mac os/
  abort("These tests require bsdtar and need to be performed under Mac OS.")
end

task :build_tars => :clobber do
  %x{
    if tar --version | grep bsdtar > /dev/null ; then
      cd res
      tar -cf ../build/bsdtar-archive.tar helloworld.rb
      gnutar -cf ../build/gnutar-archive.tar helloworld.rb
    else
      echo "Your system does not have bsdtar installed." 1>&2
      exit 1
    fi
  }
end

task :extract_bsdtar => :clean do
  Dir.mkdir("#{basepath}/build/extract_bsdtar")
  Dir.mkdir("#{basepath}/build/extract_bsdtar/bsdarchive")
  Dir.mkdir("#{basepath}/build/extract_bsdtar/gnuarchive")
  %x{
    set -e
    cd build/extract_bsdtar/bsdarchive
    tar -xf ../../bsdtar-archive.tar
    cd ../gnuarchive
    tar -xf ../../gnutar-archive.tar
  }
end

task :extract_gnutar => :clean do
  Dir.mkdir("#{basepath}/build/extract_gnutar")
  Dir.mkdir("#{basepath}/build/extract_gnutar/bsdarchive")
  Dir.mkdir("#{basepath}/build/extract_gnutar/gnuarchive")
  %x{
    set -e
    cd build/extract_gnutar/bsdarchive
    tar -xf ../../bsdtar-archive.tar
    cd ../gnuarchive
    tar -xf ../../gnutar-archive.tar
  }
end

task :extract_minitar => :clean do
  Dir.mkdir("#{basepath}/build/extract_minitar")
  Dir.mkdir("#{basepath}/build/extract_minitar/bsdarchive")
  Dir.mkdir("#{basepath}/build/extract_minitar/gnuarchive")
  Archive::Tar::Minitar.unpack("#{basepath}/build/bsdtar-archive.tar", "#{basepath}/build/extract_minitar/bsdarchive/")
  Archive::Tar::Minitar.unpack("#{basepath}/build/gnutar-archive.tar", "#{basepath}/build/extract_minitar/gnuarchive/")
end

task :untar => [ :extract_bsdtar, :extract_gnutar, :extract_minitar ]

task :test => :untar do
  require "#{basepath}/test/minitest/test_bsdarchive.rb"
  require "#{basepath}/test/minitest/test_gnuarchive.rb"
end
