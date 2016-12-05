require 'shellwords'

def normalize line
  line.gsub(/\A\s*/, '').gsub(/\Z\s*/, '')
end

def caoculate_appear_count line
  normalized = normalize(line)
  return 0 unless normalized.length > 0
  matches = `git grep -h --fixed-strings #{Shellwords.escape(normalized)}`.split(/\n/)
  complete_matches = matches.select{|matched| normalize(matched) == normalized }
  complete_matches.length
end


lines = ARGF.read.split(/\n/)
lines.each{|line|
  appear_count = caoculate_appear_count(line)
  puts [appear_count, line].join("\t")
}
