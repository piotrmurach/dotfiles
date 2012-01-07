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

if defined? Hirb
  def tables
    Hirb::Console.render_output(
      ActiveRecord::Base.connection.tables.map { |e| [e] },
      {
        :class => Hirb::Helpers::AutoTable,
        :headers => %w<tables>
      }
    )
    true
  end

  # Provide database style table view
  def table table_name
    Hirb::Console.render_output(
      ActiveRecord::Base.connection.columns(table_name).map do |e|
       [ e.name, e.type, e.sql_type, e.limit, e.default,
         e.scale, e.precision, e.primary, e.null]
      end,
      {
        :class   => Hirb::Helpers::AutoTable,
        :headers => %w<name type sql_type limit default scale precision primary null>
      }
    )
    true
  end

  # Provide overview of table counts
  def counts
    Hirb::Console.render_output(
      ActiveRecord::Base.connection.tables.map do |e|
        [e, ActiveRecord::Base.connection.select_value("SELECT COUNT(*) FROM #{e}")]
      end,
      {
        :class   => Hirb::Helpers::AutoTable,
        :headers => %w<table count>,
      }
    )
    true
  end
end
