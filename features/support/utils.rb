# Utility methods to be used in the cucumber steps
module Utils
  def select_nth(arr, n)
    arr.select.with_index { |_, i| ((i + 1) % n).zero? }
  end

  def descending?(arr)
    arr.reduce { |acc, elem| acc >= elem ? elem : (return false) }
    true
  end
end

World(Utils)
