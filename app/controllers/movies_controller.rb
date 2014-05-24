class MoviesController < ApplicationController
	def index
		if params[:sort] == 'title'
			@title_hilite = 'hilite'
		elsif params[:sort] == 'release_date'
			@release_date_hilite ='hilite'
		end
		@movies = Movie.find(:all, :order => params[:sort])
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