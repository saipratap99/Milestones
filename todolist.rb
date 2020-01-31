require "date"

class Todo
  def initialize(todo_task, due_date, completed)
    @todo_task = todo_task
    @due_date = due_date
    @completed = completed
  end

  attr_accessor :todo_task, :due_date, :completed

  def overdue?
    if Date.today > due_date
      true
    else
      false
    end
  end

  def due_today?
    if Date.today == due_date
      true
    else
      false
    end
  end

  def due_later?
    if Date.today < due_date
      true
    else
      false
    end
  end

  def to_displayable_string
    if (@completed == true && @due_date == Date.today)
      "[X]" + @todo_task
    elsif @completed == true
      "[X]" + @todo_task + " " + @due_date.to_s
    elsif @due_date == Date.today
      "[ ]" + @todo_task
    else
      "[ ]" + @todo_task + " " + @due_date.to_s
    end
  end
end

class TodosList
  def initialize(todos)
    @todos = todos
  end

  def add(todo)
    @todos << todo
  end

  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue? })
  end

  def due_today
    TodosList.new(@todos.filter { |todo| todo.due_today? })
  end

  def due_later
    TodosList.new(@todos.filter { |todo| todo.due_later? })
  end

  def to_displayable_list
    @todos.map { |todo| todo.to_displayable_string }
  end
end

date = Date.today

todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)

todos_list.add(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"

