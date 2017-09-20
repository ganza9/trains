
require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/cities")
require("./lib/trains")
require("pg")

DB = PG.connect({dbname: "train_db"})


get ('/')do
  erb(:index)
end

get('/trains')do
  @trains = Trains.all
  erb(:trains)
end

get('/trains/:id')do
  @train = Train.find(params.fetch('id'))
  erb(:train)
end

get('/trains/new')do
  erb(:trains_form)
end

post('/trains')do
  name = params.fetch('name')
  number = params.fetch('number')
  capacity = params.fetch('capacity')
  @train = Train.new(name, number, capacity)
  @train.save()
  erb(:success)
end

get('/trains/edit')do
  erb(:trains_edit_form)
end

patch('/trains/:id') do
  name = params.fetch('name')
  number = params.fetch('number')
  capacity = params.fetch('capacity')
  @train = Train.find(params.fetch('id').to_i())
  @train.update({:name => name, :number => number, :capacity => capacity})
  erb(:train)
end

delete('/trains/:id')do
  @train = Train.find(params.fetch('id').to_i())
  @train.delete()
  @trains = Train.all()
  erb(:index)
end

get('/cities')do
  @cities = Cities.all
  erb(:cities)
end

get('/cities/:id')do
  @city = City.find(params.fetch('id'))
  erb(:city)
end

get('/cities/new')do
  erb(:cities_form)
end

post('/cities')do
  name = params.fetch('name')
  @city = City.new(name)
  @city.save()
  erb(:city_success)
end

get('/cities/edit')do
  erb(:city_edit_form)
end

patch('/cities/:id')do
  name = params.fetch('name')
  @city = City.find(params.fetch('id').to_i())
  @city.update({:name => name})
  erb(:city)
end

delete('/cities/:id')do
  @city = City.find(params.fetch('id').to_i())
  @city.delete()
  @cities = City.all()
  erb(:index)
end
