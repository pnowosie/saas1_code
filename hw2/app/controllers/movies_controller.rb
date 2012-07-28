class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if (params[:sort_by].nil? && params[:ratings].nil?) && 
       (!session[:sort_by].nil? || !session[:ratings].nil?)
      redirect_to :action => 'index', :ratings => session[:ratings], :sort_by => session[:sort_by]
    end
    
    reset_session
    @all_ratings = ['G','PG','PG-13','R']
    
    @sort_by = params[:sort_by]
    session[:sort_by] = params[:sort_by]
    @sorted_by_title, @sorted_by_rdate = @sort_by == 'title', @sort_by == 'release_date'
    
    @ratings = (params[:ratings] or Hash.new)
    session[:ratings] = params[:ratings]
    
    @movies = Movie.order @sort_by
    @movies = @movies.where :rating => params[:ratings].keys unless params[:ratings].nil?
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
