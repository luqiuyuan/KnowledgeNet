class NodesController < ApplicationController

  include NodesHelper

  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  before_action :set_node, only: [:update]

  # GET /nodes
  def index
    @nodes = Node.all

    if @nodes.empty?
      respond_to do |format|
        format.json { head :not_found }
      end
    else
      respond_to do |format|
        format.json { render :index, status: :ok }
      end
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

  def update
    @node.update(node_params)

    if @node.save
      respond_to do |format|
        format.json { render 'show', status: :ok }
      end
    else
      @errors = translateModelErrors(@node)
      respond_to do |format|
        format.json { render template: 'shared/errors', status: :bad_request }
      end
    end
  end

end
