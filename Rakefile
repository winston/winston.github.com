desc "Launch Dev"
task :dev do
  Rake::Task["htmlize"].invoke
  system "jekyll --auto --server"
end

desc "Build"
task :build do |task, args|
  Rake::Task["htmlize"].invoke
  system "jekyll --pygments --no-lsi --safe"
end

desc "Convert haml layouts to html layouts"
task :htmlize do
  print "Parsing Haml layouts..."
  system(
    %{
      cd _layouts/haml &&
      for f in *.haml; do [ -e $f ] && haml $f ../${f%.haml}.html; done
    }
  )
  puts "done."
end
