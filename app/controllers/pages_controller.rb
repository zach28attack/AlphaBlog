class PagesController < ApplicationController
    before_action :set_user_global
    def home
        redirect_to articles_path if logged_in?
    end
end