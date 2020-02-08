require_relative("../db/sql_runner")
class Continent

attr_reader :id, :name
  def initialize(options)
    @id = options["id"].to_i() if options["id"]
    @name = options["name"]
  end

  def save()
    sql = "INSERT INTO continents name = $1 RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result.first["id"].to_i()
  end
  def self.all()
    sql = "SELECT * FROM continents"
    result = SqlRunner.run(sql,values)
    continents = result.map{|continent| Continent.new(continent)}
    return continents
  end
  def self.delete_all()
    sql = "DELETE FROM continents"
    SqlRunner.run(sql)
  end

end
