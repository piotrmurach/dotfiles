# Database interations inside irb

# Show ActiveRecord SQL quires
#
def show_sql(stream = STDOUT)
  ActiveRecord::Base.logger = Logger.new stream
  ActiveRecord::Base.clear_active_connections!
end

# No longer show sqls
#
def hide_sql
  show_sql nil
end

# Execute sqls
#
def sql(query)
  ActiveRecord::Base.connection.select_all(query)
end
