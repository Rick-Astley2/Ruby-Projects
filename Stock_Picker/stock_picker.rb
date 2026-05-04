def stock_picker(arr)
  stocks_picked = []
  arr_dup = arr.dup

  while true
    highest = arr_dup.find_index(arr_dup.max)
    lowest = arr_dup.find_index(arr_dup.min)

    if highest < lowest 
      arr_dup.delete(arr_dup.max)
      arr_dup.delete(arr_dup.min)
      next
    end

    break
  end

  stocks_picked << arr.find_index(arr_dup.min)
  stocks_picked << arr.find_index(arr_dup.max)

  return stocks_picked
end

stock_picker([17,3,6,9,15,8,6,1,10])