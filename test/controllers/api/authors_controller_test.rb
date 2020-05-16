# test/controllers/api/authors_controller_test.rb
require 'test_helper'

class Api::AuthorsControllerTest < ActionDispatch::IntegrationTest

  test "list API should return success" do
    get '/api/authors'
    # assert_response is rails specific assertion method
    assert_response :success
    # check reponse type
    assert_equal 'application/json; charset=utf-8', response.content_type
  end

  test "list API should return proper attributes" do
    # Expected Attributes/Fields
    expected_fields = [:id, :first_name, :last_name, :short_name]
    get '/api/authors' # make network call
    json = JSON.parse(response.body) # JSON string to JSON Array of Object.
    author_json = json.last # Get last object
    # get fields as array of keys returned in response
    actual_fields = author_json.symbolize_keys.keys
    assert_equal expected_fields.sort, actual_fields.sort
  end

  test "show API should return success" do
    author = authors(:author_1) # Get an author from dummy data
    get "/api/authors/#{author.id}"
    # assert_response is rails specific assertion method
    assert_response :success
    # check reponse type
    assert_equal 'application/json; charset=utf-8', response.content_type
  end

  test "show API should return proper attributes" do
    # Expected Attributes/Fields
    expected_fields = [:id, :first_name, :last_name, :short_name, :about_author]
    author = authors(:author_1) # Get an author from dummy data

    get "/api/authors/#{author.id}"
    author_json = JSON.parse(response.body) # JSON string to JSON Array of Object.

    # get fields as array of keys returned in response
    actual_fields = author_json.symbolize_keys.keys
    assert_equal expected_fields.sort, actual_fields.sort
  end

  test "create API should return success if all valid paramaters provided" do
    new_author_params ={ first_name:  Faker::Name.first_name, last_name: Faker::Name.last_name, about_author: Faker::Lorem.sentence(word_count: 20)}
    # total count should increase by 1 if new Author created
    assert_difference('Author.count', 1) do
      post '/api/authors', params: { author: new_author_params }
    end

    # Check response status is success
    assert_response :success

    # Check response type is JSON
    assert_equal 'application/json; charset=utf-8', response.content_type
  end

  test "create API should return newly created author" do
    new_author_params ={ first_name:  Faker::Name.first_name, last_name: Faker::Name.last_name, about_author: Faker::Lorem.sentence(word_count: 20)}
    new_author_object =  Author.new(new_author_params)
    expected_fields = [:id, :first_name, :last_name, :short_name, :about_author]
    # total count should increase if increase by 1 new Author created
    assert_difference('Author.count', 1) do
      post '/api/authors', params: { author: new_author_params }
    end
    author_json = JSON.parse(response.body).symbolize_keys
    actual_fields = author_json.keys
    # Check fields
    assert_equal expected_fields.sort, actual_fields.sort

    # Compare response and expected value for each fields

    #assert_equal author.name, author_json[:first_name]
    #assert_equal author.about_author, author_json[:last_name]
    #assert_equal author.short_name, author_json[:short_name]
    #assert_equal author.about_author, author_json[:about_author]

    # Above code can be reduced using a private method as below
    compare_response new_author_object, author_json, [:first_name, :last_name, :short_name, :about_author]
  end

  test "edit API should return success if all valid paramaters provided" do
    author = authors(:author_1)

    params_to_update ={ first_name:  Faker::Name.first_name, last_name: Faker::Name.last_name, about_author: Faker::Lorem.sentence(word_count: 20)}
    # Total count should remain the same if an existing author updated.
    assert_no_difference('Author.count') do
      put "/api/authors/#{author.id}", params: { author:  params_to_update}
    end
    # Check response status is success
    assert_response :success

    # Check response type is JSON
    assert_equal 'application/json; charset=utf-8', response.content_type
  end

  test "edit API should return updated author" do
    author = authors(:author_1)
    expected_fields = [:id, :first_name, :last_name, :short_name, :about_author]

    params_to_update ={ first_name:  Faker::Name.first_name, last_name: Faker::Name.last_name, about_author: Faker::Lorem.sentence(word_count: 20)}
    # Total count should remain the same if an existing author updated.
    assert_no_difference('Author.count') do
      put "/api/authors/#{author.id}", params: { author:  params_to_update}
    end

    author_json = JSON.parse(response.body).symbolize_keys
    actual_fields = author_json.keys

    # Check fields
    assert_equal expected_fields.sort, actual_fields.sort


    # Compare response and expected value for each fields
    expected_object = Author.new(params_to_update)

    compare_response expected_object, author_json, [:first_name, :last_name, :short_name, :about_author]
  end

  test "delete API should work properly" do
    author = authors.last
    assert_difference('Author.count', -1) do
      delete "/api/authors/#{author.id}"
    end
    assert_response 204
  end

  private
    def compare_response expected, response, fields
      fields.each do |key|
        assert_equal expected.send(key), response[key]
      end
    end

end
