class Photograph
  def initialize(attributes)
    @attributes = attributes
  end

  def id
    @attributes[:id]
  end

  def name
    @attributes[:name]
  end

  def artist_id
    @attributes[:artist_id]
  end

  def year
    @attributes[:year]
  end
end
