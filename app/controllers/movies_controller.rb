class MoviesController < ApplicationController
	def index
		@all_ratings = Movie.pluck(:rating).uniq
		if params[:ratings].nil?
			@checked = @all_ratings
			params[:sort].nil? ? @movies=Movie.all : @movies=Movie.find(:all, :order=>params[:sort]) 
		else
			@checked = params[:ratings].keys
			@movies=Movie.where(:rating => params[:ratings].keys).order(params[:sort])
		end

		if params[:sort] == 'title'
			@title_hilite = 'hilite'
		elsif params[:sort] == 'release_date'
			@release_date_hilite ='hilite'
		end

		session[:sort] = params[:sort] unless params[:sort].nil?
    	session[:ratings] = params[:ratings] unless params[:ratings].nil?
    	if !session[:ratings].nil? && ( params[:ratings].nil? || params[:sort].nil? )
    		flash.keep if !flash.nil?
      		redirect_to :action => :index, :sort => session[:sort] || "", :ratings => session[:ratings] || ""
    	end
		
	end
	def show
		id = params[:id]
		@movie = Movie.find(id)
	end
	def new
		# default: render 'new' template
	end
	def create
		@movie = Movie.create!(params[:movie])
		flash[:notice] = "#{@movie.title} was successfully created!"
		redirect_to movies_path
	end

	def edit
		@movie=Movie.find params[:id]
	end

	def update
		@movie = Movie.find params[:id]
		@movie.update_attributes!(params[:movie])
		flash[:notice] = "#{@movie.title} was successfully updated."
		redirect_to movies_path(@movie)
	end

	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy
		flash[:notice] = "Movie '#{@movie.title}' deleted"
		redirect_to movies_path
	end
end