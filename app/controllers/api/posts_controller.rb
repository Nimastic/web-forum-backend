module Api
  class PostsController < ApplicationController
  #before_action :authenticate_token
    before_action :set_post, only: [:show, :update, :destroy]

    def index
      @posts = Post.all
      render json: @posts
    end

    def show
      @post = Post.find(params[:id])
      render json: @post
    end

    def create
      @post = Post.new(post_params.merge(user_id: 1))
      @post.user = User.first # Temporarily assign the first user
      if @post.save
        render json: @post, status: :created, location: api_post_url(@post)
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      head :no_content
    end

    private

    def post_params
      params.require(:post).permit(:title, :content, :user_id)
    end
  end
end

