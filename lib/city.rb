class Cities
  attr_reader(:name)
  def initialize(attributes)
    @name = attributes.fetch(:name)
  end
  def self.all
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each() do |city|
      name = city.fetch("name")
      id = city.fetch("id").to_i()
      number = city.fetch("number").to_i
      capacity = city.fetch("capacity").to_i

      cities.push(city.new({name: name, id: id, number: number, capacity: capacity}))
    end
    cities
  end
  def save
    result = DB.exec("INSERT INTO cities (name, number, capacity) VALUES ('#{@name}', '#{@number}', '#{@capacity}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end
  def ==(another_city)
    self.name().==(another_city.name()).&(self.id().==(another_city.id()))
  end
  def self.find(id)
    found_city = nil
    city.all().each() do |city|
      if city.id().==(id)
        found_city = city
      end
    end
    found_city
  end
  def cities

  end





end
