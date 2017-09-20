class Train
  attr_reader(:name, :number, :capacity, :id)
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @number = attributes.fetch(:number)
    @capacity = attributes.fetch(:capacity)
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

      trains.push(Train.new({name: name, id: id, number: number, capacity: capacity}))
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
  def trains

  end

end
