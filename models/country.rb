require_relative("../db/sql_runner")
class Country

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options["id"].to_i() if options["id"]
    @name = options["name"]
  end

  def save()
    sql = "INSERT INTO countries (name) VALUES ($1)
    RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result.first["id"].to_i()
  end

  def update()
    sql = "UPDATE countries SET name = $1
    WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM countries WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def self.all()
    sql = "SELECT * FROM countries"
    result = SqlRunner.run(sql)
    countries = result.map{|country| Country.new(country)}
    return countries
  end

  def self.delete_all()
    sql = "DELETE FROM countries"
    SqlRunner.run(sql)
  end
  
  def self.find(id)
    sql = "SELECT * FROM countries WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    country = Country.new(result.first)
    return country
  end
end
