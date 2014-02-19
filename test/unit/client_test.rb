require 'test_helper'

describe 'Client' do
  before do
    @client = ShiftPlanning::Client.new({
      :username => 'devapi',
      :password => 'password',
      :key => 'e145a81787a46fc24802f1626befb20dcd76fd7b'
    })
    stub_request(:post, "http://www.shiftplanning.com/api/")
      .with(:body => {"data"=>"{\"key\":\"e145a81787a46fc24802f1626befb20dcd76fd7b\",\"request\":{\"module\":\"staff.login\",\"method\":\"GET\",\"username\":\"devapi\",\"password\":\"password\"}}"}, :headers => {'Content-Type'=>'application/x-www-form-urlencoded', 'Host'=>'www.shiftplanning.com', 'User-Agent'=>'RubyHTTPGem/0.5.0'})
      .to_return(:status => 200, :body => "{\"token\":\"1714d482a0f3a5e3472fb51c481dc571fd6724e1\"}", :headers => {})
  end

  describe '#authenticate' do
    it 'requests auth token and saves it' do
      @client.authenticate
      assert @client.authenticated?
    end
  end

  describe '#request' do
    it 'authenticates and makes api request' do
      stub_request(:post, "http://www.shiftplanning.com/api/")
        .with(:body => {"data"=>"{\"token\":\"1714d482a0f3a5e3472fb51c481dc571fd6724e1\",\"method\":\"UPDATE\",\"module\":\"staff.employee\",\"request\":{\"id\":1,\"addskill\":2}}"}, :headers => {'Content-Type'=>'application/x-www-form-urlencoded', 'Host'=>'www.shiftplanning.com', 'User-Agent'=>'RubyHTTPGem/0.5.0'})
        .to_return(:status => 200, :body => "{\"id\":\"1\"}", :headers => {})

      args = {
        "id" => 1,
        "addskill" => 2
      }
      @client.request('staff.employee', args, "UPDATE")
      assert true
    end
  end
end
