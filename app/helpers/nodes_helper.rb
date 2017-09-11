module NodesHelper

  # Strong parameters for node
  #
  # Comment
  # 1. May raise exception ActionController::ParameterMissing if :node is missing
  def node_params
	params.require(:node).permit(:title, :text)
  end

end
