# app.rb
require 'sinatra'
require 'net/http'
require 'net/https'
require 'json'
require './github'
  
  get '/' do
    'Api Initialized...'
  end