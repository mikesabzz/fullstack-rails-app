class InstructorsController < ApplicationController
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
end
