require 'pg'
require 'postgres_nag/commands'

module PostgresNag
  class ConnectionError < RuntimeError; end
  class DaFuq < RuntimeError; end

  class Connection
    def initialize username, password=''
      begin
        @db = PG.connect( dbname: 'postgres', user: username, password: password )
      rescue PG::ConnectionBad => e
        raise ConnectionError, e
      rescue => e
        raise DaFuq, e
      end
    end

    def execute task
      query = { select_locks: PostgresNag::SELECT_LOCKS,
      }[task]
      @db.exec(query).values.flatten.first.to_i
    end

  end
end
