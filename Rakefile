desc "Compile .haml to .html (index.haml and _layouts/)"
task :compile do
  puts "Compiling.."
  system(
    %{ haml index.haml index.html }
  )
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
  Rake::Task["compile"].invoke
  system "jekyll --auto --server"
end
