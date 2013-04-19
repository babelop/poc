require 'rake/clean'
require 'archive/tar/minitar'

CLEAN.include('build/*')
CLEAN.exclude('build/*.tar')
CLOBBER.include('build/*')

basepath = File::dirname(__FILE__)

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

task :extract_tar => :clean do
  Dir.mkdir("#{basepath}/build/extract_bintar")
  Dir.mkdir("#{basepath}/build/extract_bintar/bsdarchive")
  Dir.mkdir("#{basepath}/build/extract_bintar/gnuarchive")
  %x{
    set -e
    cd build/extract_bintar/bsdarchive
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

task :untar => [ :extract_tar, :extract_minitar ]

task :test => :untar do
  require "#{basepath}/test/minitest/test_bsdarchive.rb"
  require "#{basepath}/test/minitest/test_gnuarchive.rb"
end
