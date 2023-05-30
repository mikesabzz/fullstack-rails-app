class InstructorsController < ApplicationController
  before_action :set_instructor, only: %i[show update destroy]
  before_action :authorize_request, except: %i[index show]

  def index
    @instructors = Instructor.all
    render json: { message: "ok", instructors: @instructors }
  end
    
  def show
    begin
      @instructor = Instructor.find(params[:id])
      render json: { message: "ok", instructor: @instructor }
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'no instructor matches that ID' }, status: 404
    rescue StandardError => e
      render json: { message: e.to_s }, status: 500
    end
  end

  def create
    @instructor = Instructor.new(instructor_params)

    if @instructor.save
      render json: @instructor, status: :created
    else
      render json: @instructor.errors, status: :unprocessable_entity
    end
  end

  def update
    if @instructor.update(instructor_params)
      render json: @instructor
    else
      render json: @instructor.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @instructor.destroy
  end

  private

  def set_instructor
    @instructor = Instructor.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'no teacher matches that ID' }, status: 404
  end

  def instructor_params
    params.require(:instructor).permit(:name, :description, :photo, :link)
  end

end
