def bubble_sort(ints)
  n = ints.size

  while true
    swapped = false

    (n-1).times do |i|
      if ints[i] > ints[i+1]
        ints[i], ints[i+1] = ints[i+1], ints[i]
        swapped = true
      end
    end

    if swapped == false
      break
    end
  end

  ints
end

bubble_sort([4,3,78,2,0,2])
