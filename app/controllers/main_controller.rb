# frozen_string_literal: true

class MainController < ApplicationController
  before_action :init
  def home
    reset_session
    @form_data = FormDatum.new
  end

  def result
    Async do
      if session[:form_data_id].nil?
        redirect_to root_path
      else
        @form_data = FormDatum.find(session[:form_data_id])
        @response = @shodanClient.host_query_raw(@form_data[:prompt]).wait
        @serviceArray = @response['data']
        @hostIP = @response['ip_str']
        @hostPorts = @response['ports']
        @hostnames = @response['hostnames']
      end
    rescue RuntimeError
      puts 'Nope'
    end
  end

  def search
    FormDatum.delete_all
    @form_data = FormDatum.new(form_params)
    if @form_data.save
      session[:form_data_id] = @form_data.id
      redirect_to form_result_path
    else
      redirect_to root_path
    end
  end

  private

  def form_params
    params.require(:form_datum).permit(:prompt)
  end

  def init
    @shodanClient = ShodanAPI.new
  end
end
