def stock_picker prices
    max_profit = 0
    midx1 = -1
    midx2 = -1
    prices[0...-1].each_with_index do |price1, idx1|
        prices[idx1..-1].each_with_index do |price2, idx2|
            if price2 - price1 > max_profit
                max_profit = price2 - price1
                midx1 = idx1
                midx2 = idx2 + 1
            end
        end
    end
    return [midx1, midx2]
end
