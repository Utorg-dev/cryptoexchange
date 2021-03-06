module Cryptoexchange::Exchanges
  module Bitexlive
    module Services
      class Pairs < Cryptoexchange::Services::Pairs
        PAIRS_URL = "#{Cryptoexchange::Exchanges::Bitexlive::Market::API_URL}/tickers"

        def fetch
          output = super
          adapt(output)
        end

        def adapt(output)
          output.map do |ticker|
            next unless ticker['tradesEnabled'] == true
            base, target = ticker["tradingPairs"].split('_')
            Cryptoexchange::Models::MarketPair.new(
              base: base,
              target: target,
              market: Bitexlive::Market::NAME
            )
          end.compact
        end
      end
    end
  end
end
