require "active_record"

class Todo < ActiveRecord::Base
  # This will return true if the due_date is today otherwise it will return false
  def due_today?
    due_date == Date.today
  end

  # This will return true if the date is overdue otherwise it will return false
  def overdue?
    due_date < Date.today
  end

  # # This will return true if the due_date is due_later otherwise it will return false
  def due_later?
    due_date > Date.today
  end

  # It will return the todo result according to the date
  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  # This method is used to display the overdue,due_today and due_later todos with todo status
  def self.show_list
    puts "My Todo-list"

    puts "\nOverdue"
    puts all.order(id: :ASC).filter { |todo| todo.overdue? }.map { |todo| todo.to_displayable_string }

    puts "\n\nDue Today"
    puts all.order(id: :ASC).filter { |todo| todo.due_today? }.map { |todo| todo.to_displayable_string }

    puts "\n\nDue Later"
    puts all.order(id: :ASC).filter { |todo| todo.due_later? }.map { |todo| todo.to_displayable_string }
  end

  # Used to add a new todo in the todos table
  # return the todo which is added last in tha todos table
  def self.add_task(new_todo)
    Todo.create!(todo_text: new_todo[:todo_text], due_date: (Date.today + new_todo[:due_in_days]), completed: false)
    Todo.all.last
  end

  # Used to mark the todo as completed,
  # If the user enter correct id then it will return the altered todo result
  # otherwise return nil
  def self.mark_as_complete(todo_id)
    if Todo.ids.include? todo_id
      Todo.find(todo_id).update(completed: true)
      Todo.find(todo_id)
    end
  end
end
