require "active_record"
require "fileutils"

# Encapsulates DB init code. Currently works for SQLITE only.
class DB

  def initialize(config)
    @db = ActiveRecord::Base.establish_connection(config)
    @config = config

    if (@db.connection.tables.length == 0)
      puts "Initializing empty database"
      execute_sql_file("config/schema_sqlite3.sql")
    end
  end

  def load_fixtures(filename)
    puts "Loading fixtures from #{filename}"
    execute_sql_file(filename)
  end

  def drop_database
    db_name = @config['database']
    puts "Dropping database #{db_name}"
    FileUtils.rm(db_name)
  end

  private
    def execute_sql_file(filename)
      statements = File.read(filename).strip.split(';')
      statements.each do |sql|
        @db.connection.execute((sql << ';').strip)
      end
    end

end
