class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]

  def students
    @users = User.where(type: 'Student')
  end

  def teachers
    @users = User.where(type: 'Teacher')
  end

  def industries
    @users = User.where(type: 'Industry')
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
    @user = nil if @user && !['Student', 'Teacher'].includes?(@user.type)
  end
end
