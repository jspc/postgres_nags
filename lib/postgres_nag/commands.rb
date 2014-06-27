module PostgresNag
  SELECT_LOCKS='select count(*) from pg_stat_activity where waiting = true'
end
