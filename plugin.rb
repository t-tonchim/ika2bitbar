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

  res.code == '200' ? JSON.parse(res.body, symbolize_names: true)[:result] : nil
end

def gachi
  @gachi ||= request('/gachi/now')&.first || {}
end

def regular
  @regular ||= request('/regular/now')&.first || {}
end

def league
  @league ||= request('/league/now')&.first || {}
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
