
EXCHANGE_RATE = {bgn: 1, eur: 1.9557, usd: 1.7408, gbp: 2.6415}

def convert_to_bgn (quantity, currency)
  (EXCHANGE_RATE[currency] * quantity).round(2)
end

def compare_prices (amount_one, first, amount_two, second)
  convert_to_bgn(amount_one, first) - convert_to_bgn(amount_two, second)
end
