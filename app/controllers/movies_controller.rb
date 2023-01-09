class MoviesController < ApplicationController

    def index
        @movies = Movie.all
    end

    def show
        id = params[:id]
        begin
            @movie = Movie.find(id)    
        rescue => exception
            @movie = nil
        end
        
        if @movie == nil
            redirect_to(movies_path, alert: "Invalid movie id")
        end

    end

    def create
        begin
            @movie = Movie.create(movie_params)
        rescue => exception
            redirect_to(movies_path, alert: "Error: #{exception.message}")
        else
            redirect_to(movies_path, notice: "#{@movie.title} created successfully")
        end
    end

    def movie_params
        params.require(:movie).permit(:title, :rating, :description, :release_date)
    end

    def edit
        begin
            @movie = Movie.find(params[:id])
        rescue => exception
            redirect_to(movies_path, alert: "Error: #{exception.message}")  
        end      
    end

    def update
        begin
            @movie = Movie.find(params[:id])
            @movie.update(movie_params)
        rescue => exception
            redirect_to(movies_path, alert: "Error: #{exception.message}")  
        else
            redirect_to(movie_path(@movie))  
        end  
    end  
    
    def destroy
        begin
            @movie = Movie.find(params[:id])
            @movie.destroy
        rescue => exception
            redirect_to(movies_path, alert: "Error: #{exception.message}")  
        else
            redirect_to(movies_path, notice: "Deleted successfully")  
        end  
    end
        

end