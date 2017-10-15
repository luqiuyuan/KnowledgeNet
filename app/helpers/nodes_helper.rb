module NodesHelper

  # Strong parameters for node
  #
  # Comment
  # 1. May raise exception ActionController::ParameterMissing if :node is missing
  def node_params
	params.require(:node).permit(:title, :text)
  end

  def set_node
  	@node = Node.find(params[:id])
  rescue ActiveRecord::RecordNotFound
  	respond_to do |format|
      format.json { head :not_found }
    end
  end

end
