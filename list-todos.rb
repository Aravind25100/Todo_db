require "./connect_db.rb"
require "./todo.rb"

# Connect database to see the data in that todos table
connect_db!
Todo.show_list # to see the data in the todos table
