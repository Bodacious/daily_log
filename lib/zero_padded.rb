module ZeroPadded

  refine Integer do
    def zero_pad
      to_s.rjust(2, "0")
    end
  end
end
