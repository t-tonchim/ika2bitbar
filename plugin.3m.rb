#!/usr/bin/env ruby
# frozen_string_literal: true

require 'uri'
require 'net/http'
require 'pry'

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
 json = request('/gachi/now')
 return if json.nil?
 puts json[:rule]
end
