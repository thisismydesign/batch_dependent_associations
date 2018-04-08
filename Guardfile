guard "bundler" do
  watch("Gemfile")
end

guard :rubocop, cli: "--auto-correct" do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
end

rspec_prefix = File.file?("bin/spring") ? "bundle exec spring" : "bundle exec"
guard "rspec", cmd: "#{rspec_prefix} rspec #{ENV['FOCUS']}", all_after_pass: ENV["FOCUS"].nil? do
  watch(%r{^spec/(.+)_spec\.rb$})
  watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/models/(.+)\.rb$})                    { |m| "spec/builders/#{m[1]}_builder_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch("config/routes.rb")                           { "spec/routing" }
  watch("app/controllers/application_controller.rb")  { "spec/controllers" }
  watch(%r{^app/views/(.+)/.*\.(erb|haml)$})          { |m| "spec/requests/#{m[1]}_spec.rb" }
end

guard "rspec", cmd: "#{rspec_prefix} rspec #{ENV['FOCUS']}" do
  watch(%r{^spec/(.+)_helper.rb})                     { "spec" }
  watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
  watch(%r{^spec/factories/(.+)\.rb$})                { "spec" }
end
