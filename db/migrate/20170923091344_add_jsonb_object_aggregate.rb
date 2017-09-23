class AddJsonbObjectAggregate < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
      DROP AGGREGATE IF EXISTS jsonb_object_agg(jsonb);

      CREATE AGGREGATE jsonb_object_agg(jsonb) (
        SFUNC = 'jsonb_concat',
        STYPE = jsonb,
        INITCOND = '{}'
      );
    SQL
  end

  def down
    execute <<-SQL
      DROP AGGREGATE IF EXISTS jsonb_object_agg(jsonb);
    SQL
  end
end
