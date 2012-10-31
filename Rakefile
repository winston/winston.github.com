public_dir = "_site"
deploy_dir = "deploy"

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

  (Dir["#{deploy_dir}/*"]).each { |f| rm_rf(f) }

  puts "## Copying #{public_dir} to #{deploy_dir}"
  cp_r "#{public_dir}/.", deploy_dir

  cd "#{deploy_dir}" do
    system "git add ."
    system "git add -u"

    puts "## Commiting: Site updated at #{Time.now.utc}"
    message = "Site updated at #{Time.now.utc}"
    system "git commit -m \"#{message}\""

    puts "## Pushing generated #{deploy_dir} website"
    system "git push origin master --force"

    puts "## Deploy Complete!"
  end
end
