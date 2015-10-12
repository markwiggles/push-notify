class ListUsersTest < ActionDispatch::IntegrationTest

	test 'return users' do
		setup {host! 'api.example.com'}
		get '/users'
		assert_equal 200, response.status
		refute_empty response.body
	end

end
