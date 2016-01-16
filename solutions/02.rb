def move(snake, direction)
  last = snake.pop
  snake.push(last)
  snake.shift
  snake.push([direction[0] + last[0], direction[1] + last[1]])
end

def grow(snake, direction)
  snake.push([direction[0] + snake.last[0], direction[1] + snake.last[1]])
end

def new_food(food, snake, dimensions)
  free_cells_x = Array.new(dimensions[:width]){|x| x}
  free_cells_y = Array.new(dimensions[:height]){|y| y}
  free_cells = (free_cells_x * 2).zip((free_cells_y * 2).reverse)
  free_cells = free_cells - food - snake
  free_cells.sample
end

def obstacle_ahead?(snake, direction, dimensions)
  last_cell = move(snake,direction).pop
  last_cell[0] == dimensions[:width] or last_cell[1] == dimensions[:height]
end

def danger?(snake, direction, dimensions)
  if obstacle_ahead?(snake, direction, dimensions) then
    true
  else move(snake,direction)
    obstacle_ahead?(snake,direction,dimensions)
  end
end
