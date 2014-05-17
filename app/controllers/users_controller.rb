# -*- coding: utf-8 -*-
class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      # 保存に成功
    else
      render 'new'
    end
  end
end
