module ApplicationHelper

  # Translate error data from errors generated by models
  #
  # @param Model model
  #
  # @return [Array[Error]]
  def translateModelErrors(model)
  	errors = []
  	model.errors.details.each do |k,v|
  	  error = nil
  	  v.each do |e|
  		if e[:error] == :blank
  		  error = Error.new("missing_field", k)
  		  break
  		elsif e[:error] == :taken
          error = Error.new("duplicated_field", k)
          break
        else
  		  if !error
  			error = Error.new("invalid_field", k)
  		  end
  		end
      end
      errors << error
  	end
    errors
  end

  # Return :bad_request when ParameterMissing
  def parameter_missing(e)
    @errors = []
    error = Error.new("missing_field", e.param)
    @errors << error
    respond_to do |format|
      format.json { render template: 'shared/errors', status: :bad_request }  
    end
  end 

end
