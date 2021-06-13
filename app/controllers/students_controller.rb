class StudentsController < ApplicationController

    def index
        students = Student.all
        render json: students, status: :ok
    end

    def show
        student = find_student
        if student
            render json: student, status: :ok
        else
            render_not_found
        end
    end

    def create
        student = Student.create(student_params)
        if student.valid?
            render json: student, status: :created
        else
            render json: {error: student.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def update
        student = find_student
        if student
            student.update(student_params)
            render json: student, status: :ok
        else
            render_not_found
        end
    end

    def destroy
        student = find_student
        if student
            student.destroy
            render json: {}, status: :no_content
        else
            render_not_found
        end

    end

    private

    def find_student
        Student.find_by(id: params[:id])
    end

    def student_params
        params.permit(:name, :age, :instructor_id, :major)
    end
    
    def render_not_found
        render json: {error: "Not found"}, status: :not_found
    end
end
