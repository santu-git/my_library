# test/models/author_test.rb
require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  test "should not save author without first_name" do
    author = authors(:author_1) # loading first record from author.yml
    author.first_name = ''
    assert_not author.save # author.save should return false or nil
  end

  test 'should return validation error message if first_name is blank' do
    author = authors(:author_1)
    author.first_name = ''
    author.save
    assert_includes(author.errors[:first_name], "can't be blank")
  end

  test "should not save author without last_name" do
    author = authors(:author_1)
    author.last_name = ''
    assert_not author.save
  end

  test 'should return validation error message if last_name is blank' do
    author = authors(:author_1)
    author.last_name = ''
    author.save
    assert_includes(author.errors[:last_name], "can't be blank")
  end

  test 'should not save author if about_author is less than 15 chars' do
    author = authors(:author_1)
    author.about_author = Faker::Lorem.characters(number: 12)
    assert_not author.save
  end

  test 'should return validation error message if about_author is less than 15 chars' do
    author = authors(:author_1)
    author.about_author = Faker::Lorem.characters(number: 12)
    author.save
    assert_includes(author.errors[:about_author], "is too short (minimum is 15 characters)")
  end

  test "should save a valid record" do
    author = authors(:author_1)
    assert author.save
  end

  test "class method total_count shoud exist" do
    assert_respond_to Author, :total_count
  end

  test "total_count should return proper count" do
    assert_equal authors.count, Author.total_count
  end

  test "instance method short_name should exist" do
    author = authors(:author_20) # loading 20th record from author.yml
    assert_respond_to author, :short_name
  end

  test "instance method short_name should return proper short_name" do
    author = authors(:author_20) # loading 20th record from author.yml
    assert_equal "#{author.first_name.chars.first}. #{author.last_name}", author.short_name
  end
end
