desc "Compile .haml to .html for all files in/_layouts.haml"
task :compile_layout do
  puts "Compiling HAML layouts.."
  system(
    %{
      cd _layouts/haml && 
      for f in *.haml; do [ -e $f ] && haml $f ../${f%.haml}.html; done
    }
  )
  puts "Compiling OK.."
end

desc "Launch Dev"
task :dev do
  Rake::Task["compile_layout"].invoke
  system "jekyll --auto --server"
end
