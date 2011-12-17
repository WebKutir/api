# app.rb
require 'sinatra'
require 'net/http'
require 'net/https'
require 'json'
require './github'

set :ghuser, ENV['GH_USER']
set :ghpass, ENV['GH_PASSWORD']
set :token,  ENV['TOKEN']
set :ref, ENV['REF'] || "refs/heads/master"

helpers do
  def payload
    @payload ||= JSON.parse(params[:payload])
  end

  def repo
    @repo ||= "#{payload["repository"]["owner"]["name"]}/#{payload["repository"]["name"]}"
  end

  def github
    @github ||= GitHub.new(repo, settings.ghuser, settings.ghpass)
  end

  def authorized?
    settings.token == params[:token]
  end

  def respond_to_commits
    return "UNKNOWN APP" unless authorized?
    return "Ignoring commits to #{payload["ref"]}" unless payload["ref"] == settings.ref
    payload["commits"].reverse.each do |commit|
      yield commit
    end
    "OK"
  end
end
  
get '/' do
  'Api Initialized...'
end