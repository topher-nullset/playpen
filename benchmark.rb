require 'benchmark'
require 'pry'

def generate_random_array(length)
  min_value = 1
  exp_length = 2 ** length
  max_value = exp_length * 2
  unique_values = (min_value..max_value).to_a.shuffle
  unique_values[0, exp_length].sort
end

def find_matches_ampersand(nums1, nums2, nums3)
  result = nums1 & nums2 & nums3
  # p result
end

def find_matches_intersect(nums1, nums2, nums3)
  result = nums1.intersection(nums2, nums3)
  # p result
end

def find_matches_include(nums1, nums2, nums3)
  result = []
  nums1.each do |num|
    result << num if nums2.include?(num) && nums3.include?(num)
  end
  # p result
end

def find_matches_kiss(nums1, nums2, nums3)
  result = []
  i, j, k = 0, 0, 0

  while i < nums1.length && j < nums2.length && k < nums3.length
    num1, num2, num3 = nums1[i], nums2[j], nums3[k]

    if num1 == num2 && num2 == num3
      result << num1
      i += 1
      j += 1
      k += 1
    elsif num1 <= num2 && num1 <= num3
      i += 1
    elsif num2 <= num1 && num2 <= num3
      j += 1
    else
      k += 1
    end
  end

  # p result
end

def find_matches_sets(nums1, nums2, nums3)
  set1 = nums1.to_set
  set2 = nums2.to_set
  set3 = nums3.to_set
  result = set1.intersection(set2).intersection(set3).to_a # this is the same intersection as above
  # p result
end

def find_matches_hash(nums1, nums2, nums3)
  freq_hash = {}
  nums1.each { |num| freq_hash[num] = freq_hash[num].to_i + 1 }
  result = nums2.select { |num| freq_hash[num] && freq_hash[num] > 0 } & nums3
  # p result
end

def find_matches_reduce(nums1, nums2, nums3)
  result = [nums1, nums2, nums3].reduce(:&)
  # p result
end

# def your_matches_method(nums1, nums2, nums3)
#   your code here
# p result
# end

def benchmark_find_methods(length)
  a = generate_random_array(length)
  b = generate_random_array(length)
  c = generate_random_array(length)

  Benchmark.bm(22) do |x|
    x.report("find_matches_ampersand:") { find_matches_ampersand(a, b, c) }
    x.report("find_matches_intersect:") { find_matches_intersect(a, b, c) }
    # x.report("find_matches_include:") { find_matches_include(a, b, c) }
    # 100x slower than others, redeuce length limit to 15
    x.report("find_matches_kiss:") { find_matches_kiss(a, b, c) }
    x.report("find_matches_sets:") { find_matches_sets(a, b, c) }
    x.report("find_matches_hash:") { find_matches_hash(a, b, c) }
    x.report("find_matches_reduce:") { find_matches_reduce(a, b, c) }
    # x.report("your_find_matches_label:") { your_find_matches(a, b, c) }
  end
end

# nums_1 = [1, 2, 4, 5, 8]
# nums_2 = [2, 3, 5, 7, 9]
# nums_3 = [1, 2, 5, 8, 9]

# find_matches_ampersand(nums_1, nums_2, nums_3)
# find_matches_intersect(nums_1, nums_2, nums_3)
# find_matches_include(nums_1, nums_2, nums_3)
# find_matches_kiss(nums_1, nums_2, nums_3)
# find_matches_sets(nums_1, nums_2, nums_3)
# find_matches_hash(nums_1, nums_2, nums_3)
# find_matches_reduce(nums_1, nums_2, nums_3)
# add your method here and uncomment to test method functionality

(10..20).each do |length|
  puts "Benchmark for length #{length}:"
  benchmark_find_methods(length)
  puts "\n"
end
