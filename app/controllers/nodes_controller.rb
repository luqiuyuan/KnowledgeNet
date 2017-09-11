class NodesController < ApplicationController

  include NodesHelper

  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  # GET /nodes
  def index
    @nodes = Node.all

    respond_to do |format|
      format.json { render :index, status: :ok }
    end
  end

  def create
    @node = Node.new(node_params)

    if @node.save
      respond_to do |format|
        format.json { render 'show', status: :created }
      end
    else
      @errors = translateModelErrors(@node)
      respond_to do |format|
        format.json { render template: 'shared/errors', status: :bad_request }
      end
    end
  end

end
