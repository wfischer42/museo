class Artist
  def initialize(attributes)
    @attributes = attributes
  end

  def id
    @attributes[:id]
  end

  def name
    @attributes[:name]
  end

  def born
    @attributes[:born]
  end

  def died
    @attributes[:died]
  end
  
  def country
    @attributes[:country]
  end
end
