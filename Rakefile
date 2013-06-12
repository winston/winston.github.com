require 'date'

public_dir = "_site"
deploy_dir = "deploy"

desc "Create a New Post"
task :post do
  posts_dir = "_posts"

  def slug(text)
    text.downcase.gsub(/\s/, "_")
  end

  date  = Date.today.to_s
  STDOUT.print "Title: "
  title = STDIN.gets.strip
  slug  = slug(title)
  post  = "#{date}-#{slug}"

  file = File.new("#{posts_dir}/#{post}.markdown", "w+")
  file.write("---\n")
  file.write("layout: post\n")
  file.write("title: #{title}\n")
  file.write("---\n")
  system "ls _posts/*#{slug}*"
end

desc "Launch Dev"
task :dev do
  system "jekyll serve --watch"
end

desc "Build"
task :build do
  system "jekyll build #{public_dir}"
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
