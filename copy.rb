#!/usr/bin/env ruby
#
# テキストをScrapbox.io/toshiyukimasui/copy にコピーする
#
# % copy                # コピーページを開く
# % copy text           # textをコピーページに書き込む
# % echo text | copy    # textをコピーページに書き込む
#

require 'uri'

project = 'toshiyukimasui'
page = 'copy'
url = "http://scrapbox.io/#{project}/#{page}"

if `which open` != ""
  open = "open"
elsif `which xdg-open` != ""
  open = "xdg-open"
else
  STDERR.puts "open command not found"
  exit
end

text = nil
if ARGV.length > 0 then
  text = ARGV[0].dup
elsif FileTest.pipe?(STDIN)
  text = STDIN.readlines.join('')
end

url = "#{url}?body=#{URI.encode(text)}" if text

system "#{open} '#{url}'"
