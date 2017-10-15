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

  #=================================
  # tests for PATCH / PUT nodes
  #=================================

  test "should update node" do
    node = nodes(:one)

    patch :update, format: :json, id: node.id, node: {title:"updated title", text:"updated text"}

    assert_response :ok
    assert_template :show
    assert hash_included_unordered(
      {
        title: "updated title",
        text: "updated text"
      },
      json_response['node']
    )
  end

  test "should return status 404 if node of the id does not exist" do
    patch :update, format: :json, id: 1234567
  end

  test "should return errors if param node is missing" do
    node = nodes(:one)

    patch :update, format: :json, id: node.id

    assert_response :bad_request
    assert_template 'shared/errors'
    assert hash_included_unordered({errors:[{code:'missing_field', field:'node'}]}, json_response)
  end

  test "should return errors if param node is an empty hash" do
    node = nodes(:one)

    patch :update, format: :json, id: node.id, node: {}

    assert_response :bad_request
    assert_template 'shared/errors'
    assert hash_included_unordered({errors:[{code:'missing_field', field:'node'}]}, json_response)
  end

  test "should not update node if title is too long" do
    node = nodes(:one)

    patch :update, format: :json, id: node.id, node: {title: "a"*(Node::TITLE_LENGTH_MAX+1)}

    assert_response :bad_request
    assert_template 'shared/errors'
    assert hash_included_unordered({errors:[{code:'invalid_field', field:'title'}]}, json_response)
  end

  test "should not update node if text is too long" do
    node = nodes(:one)

    patch :update, format: :json, id: node.id, node: {text: "a"*(Node::TEXT_LENGTH_MAX+1)}

    assert_response :bad_request
    assert_template 'shared/errors'
    assert hash_included_unordered({errors:[{code:'invalid_field', field:'text'}]}, json_response)
  end

  test "should not update node if title is empty string" do
    node = nodes(:one)

    patch :update, format: :json, id: node.id, node: {title: ""}

    assert_response :bad_request
    assert_template 'shared/errors'
    assert hash_included_unordered({errors:[{code:'missing_field', field:'title'}]}, json_response)
  end

  test "should not update node if title is nil" do
    node = nodes(:one)

    patch :update, format: :json, id: node.id, node: {title: nil}

    assert_response :bad_request
    assert_template 'shared/errors'
    assert hash_included_unordered({errors:[{code:'missing_field', field:'title'}]}, json_response)
  end

end
