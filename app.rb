# app.rb
require 'sinatra'
require 'net/http'
require './github'
  
  get '/' do
    'Api Initialized...'
  end