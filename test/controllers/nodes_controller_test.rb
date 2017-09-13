require 'test_helper'

class NodesControllerTest < ActionController::TestCase
  
  #=================================
  # tests for GET nodes
  #=================================

  test "should show all nodes" do
    get :index, format: :json

    assert_response :ok
    assert_template :index

    one = nodes(:one)
    two = nodes(:two)
    assert hash_included_ordered({nodes: [
      {
        id: one.id,
        title: one.title,
        text: one.text
      },
      {
        id:two.id,
        title: two.title,
        text: two.text
      }
    ]}, json_response)
  end

  test "should return 404" do
    Node.destroy_all

    get :index, format: :json

    assert_response :not_found
  end

  #=================================
  # tests for POST nodes
  #=================================

  test "should create node" do
    post :create, format: :json, node: {title: "New Title", text: "Content"}

    assert_response :created
    assert_template :show
    assert hash_included_ordered({node: {
      title: "New Title",
      text: "Content"
    }}, json_response)
  end

  test "should not create node (param node is missing)" do
    post :create, format: :json

    assert_response :bad_request
    assert_template 'shared/errors'
    assert hash_included_unordered({errors:[{code:'missing_field', field:'node'}]}, json_response)
  end

  test "should not create node (param node:title is missing)" do
    post :create, format: :json, node: {text: "Content"}

    assert_response :bad_request
    assert_template 'shared/errors'
    assert hash_included_unordered({errors:[{code:'missing_field', field:'title'}]}, json_response)
  end

  test "should not create node (param node:title is invalid)" do
    post :create, format: :json, node: {title: "New Title", text: "a"*(Node::TEXT_LENGTH_MAX+1)}

    assert_response :bad_request
    assert_template 'shared/errors'
    assert hash_included_unordered({errors:[{code:'invalid_field', field:'text'}]}, json_response)
  end

end
