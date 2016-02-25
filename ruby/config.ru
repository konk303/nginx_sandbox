require 'pry'

# start with `cd ruby && thin start -C thin.yml`
# stop with `cd ruby && thin stop`
class RackApp
  attr_accessor :request, :response

  def self.call(env)
    new(env).response
  end

  def initialize(env)
    @request = Rack::Request.new env
    @response = Rack::Response.new [], 200, 'Content-Type' => 'text/html'
    action
  end

  def action
    # binding.pry
    response.body << '<html><head><title>rack app</title></head><body>'
    response.body << '<h1 style="color: DarkSlateGrey;">rack app responding</h1>'
    response.body << '<a href="/">root</a>'
    response.body << '<ul>'
    response.body << "<li>url: #{request.url}</li>"
    response.body << "<li>path: #{request.path_info}</li>"
    response.body << "<li>params: #{request.params}</li>"
    response.body << '</ul>'
    response.body << '</body></html>'
  end
end

run RackApp
