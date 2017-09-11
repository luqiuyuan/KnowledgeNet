require 'test_helper'

class NodeTest < ActiveSupport::TestCase

  def setup
  	@node = Node.new(title:"New Node", text:"Content")
  end

  test "valid node should save" do
  	assert_difference 'Node.count', 1 do
  	  @node.save
  	end
  end

  test "invalid node should not save (title is empty)" do
  	assert_no_difference 'Node.count' do
  	  @node.title = nil
  	  @node.save
  	end
  end

  test "invalid node should not save (title is too long)" do
  	assert_no_difference 'Node.count' do
  	  @node.title = "a" * (Node::TITLE_LENGTH_MAX + 1)
  	  @node.save
  	end
  end

  test "invalid node should not save (text is too long)" do
  	assert_no_difference 'Node.count' do
  	  @node.text = "a" * (Node::TEXT_LENGTH_MAX + 1)
  	  @node.save
  	end
  end

end
