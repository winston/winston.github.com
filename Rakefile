deploy_dir = "deploy"
public_dir = "tmp"

desc "Launch Dev"
task :dev do
  system "jekyll --auto --server"
end

desc "Build"
task :build do
  system "jekyll #{public_dir}"
end

# Stolen from Octopress
desc "Deploy"
task :deploy do
  puts "## Deploying to Github Pages.."

  puts "\n## Copying #{public_dir} to #{deploy_dir}"
  cp_r "#{public_dir}/.", deploy_dir

  cd "#{deploy_dir}" do
    system "git add ."
    system "git add -u"

    puts "\n## Commiting: Site updated at #{Time.now.utc}"
    message = "Site updated at #{Time.now.utc}"
    system "git commit -m \"#{message}\""

    puts "\n## Pushing generated #{deploy_dir} website"
    #system "git push origin master --force"

    puts "\n## Deploy Complete!"
  end
end
