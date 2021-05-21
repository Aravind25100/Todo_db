require "./connect_db.rb"
require "./todo.rb"

# Connect database to do some modifications in that todo records
connect_db!
Todo.show_list # Display the todo data

puts "\nWhich todo do you want to mark as complete? (Enter id): "
todo_id = gets.strip.to_i

todo = Todo.mark_as_complete(todo_id) # Here i am trying to change the todo's status

# If it is successfully change the todo's status it will display the todo result
# otherwise it will display the error message
puts todo != nil ? todo.to_displayable_string : "Error ! You have entered an invalid id."
