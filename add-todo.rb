require "./connect_db.rb"
require "./todo.rb"

# Used to get an input from the user
# If user enters a valid input it will return the hash with the todo_text and due_date
# otherwise it will return nil
def get_new_todo
  puts "Todo text:"
  todo_text = gets.strip
  return nil if todo_text.empty?

  puts "How many days from now is it due? (give an integer value)"
  due_in_days = gets.strip.to_i

  {
    todo_text: todo_text,
    due_in_days: due_in_days,
  }
end

# Connect database to add a new todo in that todos table
connect_db!
h = get_new_todo

# It will add a new todo if the hash is not nil
# Otherwise it will display the error message
if h
  if (Date.today + h[:due_in_days]) >= Date.today
    new_todo = Todo.add_task(h)
    puts "New todo created with id #{new_todo.id}"
    Todo.show_list
  else
    puts "Error! You cannot create a todo with overdue date!"
  end
end
