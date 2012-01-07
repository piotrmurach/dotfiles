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

# Easy modle finders
def define_model_find_shortcuts
  model_files = Dir.glob("app/models/**/*.rb")
  table_names = model_files.map { |f| File.basename(f).split('.')[0..-2].join }
  table_names.each do |table_name|
    Object.instance_eval do
      define_method(table_name) do |*args|
        table_name.camelize.constantize.send(:find, *args)
      end
    end
  end
end

IRB.conf[:IRB_RC] = Proc.new { define_model_find_shortcuts }
