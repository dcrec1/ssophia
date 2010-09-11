task :clean do
  system "rm rerun.txt"
end

task :build => %w(clean db:migrate spec cucumber metrics:all)
