require("spec_helper")
require('train')

describe(Train)do
  describe(".all")do
    it("starts off with no trains")do
      expect(Train.all()).to(eq([]))
    end
  end
  describe('#name') do
    it 'tells you its name' do
      train = Train.new({name: "Epicodus Line", id: nil, number: 1, capacity: 300})
      expect(train.name()).to(eq("Epicodus Line"))
    end
  end
  describe('#id')do
    it 'sets the ID when you save' do
      train = Train.new({:name => "Epicodus Line", id: nil, number: 1, capacity: 300})
      train.save()
      expect(train.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#==') do
    it("is the same train if it has the same name") do
      train1 = Train.new({name: "E Line", number: 1, capacity: 300, id: nil })
      train2 = Train.new({name: "E Line", number: 1, capacity: 300, id: nil})
      expect(train1).to(eq(train2))
    end
  end
  describe('.find') do
    it('returns a list by its id') do
      test_train = Train.new({name: "E Line", number: 1, capacity: 300, id: nil})
      test_train.save()
      test_train2 = Train.new({name: "D Line", number: 2, capacity: 200, id: nil})
      test_train2.save()
      expect(Train.find(test_train2.id())).to(eq(test_train2))
    end
  end











end
