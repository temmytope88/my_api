class ApplicationController < ActionController::Base
    require 'pagy/extras/array'
    include Pagy::Backend
    include Pagy::Frontend  
end
