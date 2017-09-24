class PostsController < ApplicationController
  before_action :authenticate_user, :only => [:create, :index,:show]
  before_action :set_cache_buster

  def create
    params[:username] = @current_user.username
    params_received = post_params
    if params_received
      @post = Post.create(post_params)
      redirect_to posts_path
    else
      redirect_to(:controller => 'posts', :action => 'index')
    end
  end

  def index
    @post_create = Post.new
    @post_create.add_username(@current_user.username)
    @post_show = Post.where(:username => @current_user.username)
  end

  def show
    @post = Post.find(params[:id])
  end

  private
  def post_params
    if !params[:post]
      return nil
    end
    ret_params = params.require(:post).permit(:image)
    ret_params[:username] = @current_user.username
    return ret_params;
  end
end
