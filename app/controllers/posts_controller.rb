class PostsController < ApplicationController
  def create
    builder = PostBuilder.new(
      title:   params[:title],
      content: params[:content],
      login:   params[:login],
      ip:      params[:ip]
    )
    builder.inspect!
    render json: builder.save, status: 200
  rescue => exc
    render json: { error: exc.message }, status: 422
  end

  def top
    render json: Post.get_top(params[:count])
  end
end
