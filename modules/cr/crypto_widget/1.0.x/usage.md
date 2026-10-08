Crypto Widget provides a placeable block that shows the live price of a chosen cryptocurrency, fetched client-side from the public Coinbase API.

---

The module adds a single block plugin ("Crypto widget"). When you place it, you pick one of 16 supported coins (Bitcoin, Ethereum, Tether, Cardano, Bitcoin Cash, Litecoin, Uniswap, Chainlink, Ethereum Classic, Stellar, USD Coin, Filecoin, Wrapped Bitcoin, Bitcoin SV, Cosmos, Dash), a fiat currency (EUR or USD), and a refresh period (5, 10, 30 or 60 minutes). The rendered block is a small card showing the coin icon, its current spot price, and percentage changes over the configured period, over one day and over one week. All price data is retrieved in the browser via `fetch()` against `https://api.coinbase.com/v2/prices/{COIN}-{CURRENCY}/spot` — there is no server-side HTTP call, no stored API key, and no configuration form beyond the block placement dialog. Coin icons are bundled as an icomoon web font. The module has no dependencies outside Drupal core, defines no routes, permissions, services or Drush commands, and only ships config schema for the block settings.

---

- Display a live Bitcoin (BTC) spot price in a sidebar block on a finance/news site.
- Show an Ethereum (ETH) price ticker in the site header or footer region.
- Give visitors a quick USD or EUR quote for a stablecoin such as USDT, USDC or DAI-adjacent assets supported by the list.
- Add multiple blocks (one per coin) to build a small crypto price board in one region.
- Show the percentage change of a coin over the last N minutes to convey short-term movement.
- Surface one-day and seven-day price change alongside the current price for a trend snapshot.
- Refresh the displayed price automatically every 5, 10, 30 or 60 minutes without a page reload.
- Localize the widget's static labels ("Change in the last", "min", "1D", "7D") through Drupal's translation system.
- Restrict the block to specific pages, roles or content types using standard core block visibility settings.
- Place a coin ticker on a landing page to signal that a site accepts or discusses that cryptocurrency.
- Present price context next to a "donate with crypto" call-to-action.
- Show a Litecoin (LTC) or Bitcoin Cash (BCH) price for a merchant that quotes in those coins.
- Compare two currencies by placing the same coin twice, once with EUR and once with USD.
- Embed the widget in a Drupal theme region via configuration only, with no custom code.
- Provide a low-maintenance price display that needs no API credentials or server configuration.
- Add a themed price card whose look can be overridden via the `crypto-widget.html.twig` template.
- Style the widget per site by overriding the module's `css/widget.css` in a custom theme.
- Demonstrate a client-side data-fetching block pattern as a reference implementation.
- Give editors a self-service way to add a price block through the standard Block Layout UI.
- Show Cardano (ADA), Cosmos (ATOM) or Chainlink (LINK) prices for altcoin-focused audiences.
