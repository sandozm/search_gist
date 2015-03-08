class GistController < ApplicationController
  def index
  	gist = Gist.new
  	uri = "https://api.github.com/gists/public?per_page=200"

  	if params[:search]
  		@gists = gist.APIGist(uri, params[:search])
  	else
  		@gists = gist.APIGist(uri)
  	end
  end

  def list
  	@gists = Gist.all
  end

  def delete
  	if request.delete?
  		if Gist.find(params[:id]).destroy
  			redirect_to({ :controller => 'gist', :action => 'list' }, :notice => 'Le gist a bien été effacé !')
  		else
  			redirect_to({ :controller => 'gist', :action => 'list' }, :alert => 'Une erreur est survenue lors de l\'effacement du gist.')
  		end
  	end
  end

  def save
  	if request.post?
  		gist = Gist.new
  		uri = "https://api.github.com/gists/#{params[:id]}"
  		getGist = gist.APIGist(uri)

  		gist.id_gist = getGist['id']
  		gist.owner = getGist['owner']['login']
  		gist.avatar_url = getGist['owner']['avatar_url']
  		gist.html_url = getGist['owner']['html_url']
  		if getGist['description']
  			gist.description = getGist['description']
  		end

  		if gist.save
  			redirect_to({ :controller => 'gist', :action => 'index' }, :notice => 'Le gist a bien été ajouté !')
  		else
  			redirect_to({ :controller => 'gist', :action => 'index' }, :alert => 'Une erreur est survenue lors de l\'ajout du gist.')
  		end
  	end
  end
end
