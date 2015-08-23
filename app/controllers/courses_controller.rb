class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :set_user, except: [:index, :show]
  before_action :set_offer_teacher, only: [:offer]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Curso criado com sucesso.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Curso atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy

    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Curso destruído com sucesso.' }
      format.json { head :no_content }
    end
  end

  def teach
    return unless check_user('industry')

    @course.teachers << @user
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Você se inscreveu para ministrar o curso com sucesso.' }
    end
  end

  def rate
    return unless check_user('student') && @course.students.exists?(@user)

    rating_params= params.require(:rating)
    rating_val = rating_params[:rating].to_i

    rating = @course.ratings.find_or_initialize_by(user: @user)
    rating.update!(rating: rating_val)

    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Você avaliou o curso com sucesso.' }
    end

  end

  def offer
    return unless check_user('industry') && check_user('teacher', @teacher)

    offer_params = course_offer_params
    offer_params[:industry_id] = @user.id
    offer_params[:teacher_id] = @teacher.id

    @course.offers << CourseOfferParams.new(offer_params)
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Você criou uma oferta de recurso com sucesso.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_offer_teacher
    @teacher = User.find(params[:course_offer][:teacher_id])
  end

  def check_user(type, user = nil)
    user ||= @user

    if !user || user.type != type
      respond_with do
        format.html { redirect_to courses_url, notice: 'Action failed, wrong kind of user.' }
      end

      return false
    end

    true
  end

  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def course_params
    params.require(:course).permit(:requirements, :cost, :description)
  end

  def course_offer_params
    params.require(:course_offer).permit(:teacher_id, :date, :location)
end
