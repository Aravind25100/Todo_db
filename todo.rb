require "active_record"

class Todo < ActiveRecord::Base
  # # This will return the list of due_today todos
  def self.due_today
    all.order(id: :ASC).where("due_date = ?", Date.today)
  end

  #This will return the list of overdue todos
  def self.overdue
    all.order(id: :ASC).where("due_date < ?", Date.today)
  end

  # This will return the list of due_later todos
  def self.due_later
    all.order(id: :ASC).where("due_date > ?", Date.today)
  end

  # It will return the todo result according to the date
  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_date == Date.today ? nil : due_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  # This method is used to display the overdue,due_today and due_later todos with todo status
  def self.show_list
    puts "My Todo-list"

    puts "\nOverdue"
    puts overdue.map { |todo| todo.to_displayable_string }

    puts "\n\nDue Today"
    puts due_today.map { |todo| todo.to_displayable_string }

    puts "\n\nDue Later"
    puts due_later.map { |todo| todo.to_displayable_string }
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
