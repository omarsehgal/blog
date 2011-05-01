class CommentsController < ApplicationController
	
	before_filter :authenticate, :only => :destroy
	
	def create
		@post = Post.find(params[:post_id])
#		@comment = @post.comments.create(params[:comment])
		@comment.create(params[:comment], @post)
#		redirect_to post_path(@post)
		
    	respond_to do |format|
	      	if @comment.save
    	    	format.html {redirect_to(post_path(@post), :notice => 'Comment was successfully created.')}
      		else
    	    	format.html {redirect_to(post_path(@post), :notice => 'Failed to create comment.')}
    	    	format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      		end
    	end		
	end
	
	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end
end
