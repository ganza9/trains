
class Train
  attr_accessor(:name, :number, :capacity, :id)
  
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @number = attributes.fetch(:number).to_i
    @capacity = attributes.fetch(:capacity).to_i
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      name = train.fetch("name")
      id = train.fetch("id").to_i()
      number = train.fetch("number").to_i
      capacity = train.fetch("capacity").to_i
      attributes = {:name => name, :number => number, :capacity => capacity, :id => id}
      trains.push(Train.new(attributes))
    end
   trains
  end

  def save
    result = DB.exec("INSERT INTO trains (name, number, capacity) VALUES ('#{@name}', '#{@number}', '#{@capacity}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_train)
    self.name().==(another_train.name()).&(self.id().==(another_train.id()))
  end

  def self.find(id)
    found_train = nil
    Train.all().each() do |train|
      if train.id().==(id)
        found_train = train
      end
    end
    found_train
  end

  def delete
    DB.exec("DELETE FROM trains WHERE id = #{@id};")
  end

end
