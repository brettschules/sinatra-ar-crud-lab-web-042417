require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :new
  end


  post '/posts' do

      Post.create(name: params[:name], content: params[:content])

      redirect to '/posts'
  end

  get '/posts/new' do

    erb :new
  end

  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do
  if   @post = Post.find(params[:id])
        erb :show
      else
        redirect '/'
      end
  end

  get '/posts/:id/edit' do
    if @post = Post.find(params[:id])
      erb :edit
    else
      redirect '/posts'
    end
  end

  patch '/posts/:id' do
    @post = Post.find(params[:id])
    @post.update(name: params[:name], content: params[:content])
    @post.save
    redirect "/posts/#{@post.id}"
  end

  delete '/posts/:id' do
    @post = Post.find(params[:id])
    @post.destroy
    erb :delete
  end
 end
