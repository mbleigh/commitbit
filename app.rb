require 'sinatra'
require 'octokit'

module CommitBit
  class App < Sinatra::Base
    set :show_exceptions, false
    not_found do
      erb :not_found
    end
    
    error Octokit::NotFound do
      status 404
      erb :not_found
    end
    
    error do
      erb :error
    end
    
    get '/' do
      erb :home
    end
    
    get '/auth/github/callback' do
      auth_hash = request.env['omniauth.auth']
      session[:user] = {
        name: auth_hash.info.nickname,
        email: auth_hash.info.email
      }
      session[:token] = auth_hash.credentials.token
      
      redirect session.delete(:return) || '/'
    end
    
    get '/logout' do
      session.destroy
      redirect '/'
    end
    
    get '/:user/:repo' do
      require_login!
      
      @repo = Octokit.repo([params[:user], params[:repo]].join('/'))
      erb :repo
    end
    
    def require_login!
      unless session[:user]
        session[:return] = request.path
        redirect '/auth/github'
      end
    end
    
    helpers do
      def logged_in?
        !!current_user
      end
      
      def current_user
        session[:user]
      end
    end
  end
end