class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(name: params[:pet_name])
    # binding.pry
    if params["owner"]["name"].empty?
      @pet.update(owner_id: params[:owner_id])
    else
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owner = @pet.owner
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    # if !params[:pet].keys.include?("owner_id")
    #   params[:pet]["owner_id"] = nil
    # end

    @pet = Pet.find(params[:id])
    @pet.update(name: params[:pet_name])
    if params["owner"]["name"].empty?
      @pet.update(owner_id: params[:owner_id])
    else
      @pet.owner = Owner.create(name: params["owner"]["name"])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end