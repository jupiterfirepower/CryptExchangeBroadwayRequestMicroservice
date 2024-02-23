import Config

config :cryptexdp, Cryptexdp.Scheduler,
  jobs: [
    # Every minute

    {"* * * * *",  fn ->
                          urls = [
                            "https://api.binance.com/api/v3/depth?limit=100&symbol=BTCUSDT",
                            "https://api.bitforex.com/api/v1/market/depth?size=200&symbol=coin-usdt-btc",
                            "https://api.bitget.com/api/spot/v1/market/depth?limit=100&symbol=BTCUSDT_SPBL&type=step0",
                            "https://api.bitmake.com/t/v1/quote/depth?depthLevel=100&symbol=BTC_USDT",
                            "https://api-pub.bitfinex.com/v2/book/tALGBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tAMPBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tANTBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tATOBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tAVAX:BTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tBMNBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tBTC:CNHT/R0",
                            "https://api-pub.bitfinex.com/v2/book/tBTC:MXNT/R0",
                            "https://api-pub.bitfinex.com/v2/book/tBTC:XAUT/R0",
                            "https://api-pub.bitfinex.com/v2/book/tBTCEUR/R0",
                            "https://api-pub.bitfinex.com/v2/book/tBTCEUT/R0",
                            "https://api-pub.bitfinex.com/v2/book/tBTCGBP/R0",
                            "https://api-pub.bitfinex.com/v2/book/tBTCJPY/R0",
                            "https://api-pub.bitfinex.com/v2/book/tBTCMIM/R0",
                            "https://api-pub.bitfinex.com/v2/book/tBTCTRY/R0",
                            "https://api-pub.bitfinex.com/v2/book/tBTCUSD/R0",
                            "https://api-pub.bitfinex.com/v2/book/tBTCUST/R0",
                            "https://api-pub.bitfinex.com/v2/book/tCCDBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tDAIBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tDOGE:BTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tDOTBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tDSHBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tDUSK:BTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tETHBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tIOTBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tJSTBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tLEOBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tMATIC:BTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tMNABTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tNEOBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tNEXO:BTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tOMGBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tQTFBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tSOLBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tTRXBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tVETBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tWBTBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tXAUT:BTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tXLMBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tXMRBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tXRDBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tXRPBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tXTZBTC/R0",
                            "https://api-pub.bitfinex.com/v2/book/tZECBTC/R0",
                            "https://www.bitstamp.net/api/v2/order_book/btcusd/",
                            "https://www.bitstamp.net/api/v2/order_book/btceur/",
                            "https://api-testnet.bybit.com/v5/market/orderbook?category=spot&symbol=BTCUSDT",
                            "https://cex.io/api/order_book/BTC/USD/",
                            "https://api.crypto.com/exchange/v1/public/get-book?depth=150&instrument_name=BTCUSD-PERP",
                            "https://openapi.digifinex.com/v3/order_book?limit=150&symbol=btc_usdt",
                            "https://api.gateio.ws/api/v4/spot/order_book?currency_pair=BTC_USDT",
                            "https://api.sandbox.gemini.com/v1/book/btcusd/",
                            "https://api.sandbox.gemini.com/v1/book/ethbtc/",
                            "https://api.sandbox.gemini.com/v1/book/ethusd/",
                            "https://api.sandbox.gemini.com/v1/book/zecusd/",
                            "https://api.sandbox.gemini.com/v1/book/zecbtc/",
                            "https://api.sandbox.gemini.com/v1/book/zeceth/",
                            "https://api.sandbox.gemini.com/v1/book/zecbch/",
                            "https://api.sandbox.gemini.com/v1/book/zecltc/",
                            "https://api.sandbox.gemini.com/v1/book/bchusd/",
                            "https://api.huobi.pro/market/depth?symbol=btcusdt&type=step0",
                            "https://api.kraken.com/0/public/Depth?count=100&pair=BTCUSDT",
                            "https://api.poloniex.com/markets/BTC_USDT/orderBook?limit=150",
                            "https://api.probit.com/api/exchange/v1/order_book?market_id=PROB-USDT",
                            "https://whitebit.com/api/v4/public/orderbook/BTC_USDT?level=0&limit=100",
                          ]
                          Cryptexdp.UrlProducer.get_service_data_by_url(urls) end},
    #{{:cron, "* * * * *"},     {Heartbeat, :send, []}},
  ]