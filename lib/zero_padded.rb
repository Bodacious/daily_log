# Extends the Integer class with zero-padded numbers, so that months are days
# all always shown as double-digit numbers.
#
# Examples
#
#   class MyClass
#
#     using ZeroPadded
#
#     def print_number
#       print 1.zero_pad # => "0.1"
#     end
#
module ZeroPadded

  refine Integer do

    # Return the value of an Integer zero-padded to a min of 2 chars
    def zero_pad
      to_s.rjust(2, "0")
    end

  end
end
