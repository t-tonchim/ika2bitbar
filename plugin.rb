#!/usr/bin/env ruby
# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'json'

API_ROOT = 'https://spla2.yuu26.com/'

def request(path = '/')
  request_path = File.join(API_ROOT, path)
  url = URI.parse(request_path)
  req = Net::HTTP::Get.new(url.path)
  res = Net::HTTP.start(url.host, url.port, use_ssl: true) do |http|
    http.request(req)
  end

  return {} unless res.code == '200'

  JSON.parse(res.body, symbolize_names: true)[:result].first
end

def gachi
  @gachi ||= request('/gachi/now')
end

def regular
  @regular ||= request('/regular/now')
end

def league
  @league ||= request('/league/now')
end

puts '🦑'
puts '---'

puts 'ガチマッチ | color=#ff8300 size=18'
puts "ルール:  #{gachi[:rule]} | color=white"
puts "マップ:  #{gachi[:maps]&.join(', ')} | color=white"
puts '---'

puts 'レギュラーマッチ | color=#b6ef30 size=18'
puts "マップ:  #{regular[:maps]&.join(', ')} | color=white"
puts '---'

puts 'リーグマッチ | color=#6525fd size=18'
puts "ルール:  #{league[:rule]} | color=white"
puts "マップ:  #{league[:maps]&.join(', ')} | color=white"
