# Configuration

Commerce Exchanger is configured by creating one or more **Exchange rates**
sources and choosing how each one gets its rates. This page walks through
creating a source, the two kinds of providers, importing rates, and displaying
converted prices.

## Open the Exchange rates screen

1. Log in as a user with the **Administer commerce exchanger settings**
   permission.
2. Go to **Commerce → Configuration → Exchange rates**, or navigate directly to
   `/admin/commerce/config/exchange-rates`.

This is a list of your exchange-rate sources. Click **Add exchange rates** to
create one.

## Create an exchange-rate source

Each source has a **label**, and a **provider plugin** that determines where its
rates come from. Choose the provider that fits your needs:

| Provider | Needs credentials? | Notes |
|---|---|---|
| **Manual** | No | You type in and maintain the rates yourself. |
| **European Central Bank (ECB)** | No | Fetches daily EUR-based rates. |
| **Fixer** | API key | Commercial rate API. |
| **Currencylayer** | API key | Commercial rate API. |
| **Open Exchange Rates** | API key | Commercial rate API. |
| **TransferWise** | Account | Mid-market rates. |

### Manual rates

Pick the **Manual** provider when you want full control — for example a finance
team that fixes rates on a schedule, or a test/staging site where you want
checkout math to be deterministic. You enter and maintain the currency ratios
directly. No external API is contacted.

### Remote (automatic) providers

Pick one of the remote providers to have rates fetched from an external service.
Depending on the provider you'll configure some of the following:

- **API key** (Fixer, Currencylayer, Open Exchange Rates) — the credential from
  your provider account. Keep this out of committed configuration; see the note
  on secrets in [Installation](../installation/index.md#a-note-on-api-keys-and-secrets).
- **Base currency** — the currency all rates are expressed relative to. Some
  providers (like ECB) are locked to their own base (EUR); others let you choose.
- **Enterprise mode** — for provider plans that allow fetching by any base
  currency directly.
- **Cross sync** — when a provider only supplies rates against a single base
  currency, derive the other currency pairs by cross-conversion.
- **Transform rates** — flip the ratios when a provider publishes them the
  reverse way (target→source instead of source→target).
- **Refresh once / cron** — how often to fetch. Some free tiers update only once
  per day, so you can throttle imports accordingly.
- **Historical rates** — keep a per-day history of rates in addition to the
  latest set, useful for auditing or reporting.

Save the source when you're done.

## Manual per-currency overrides

Even with a remote provider, you can override a single currency pair by hand.
Those overrides are marked as manual so that automated syncs leave them alone —
handy when you want most rates to sync automatically but pin one pair to a
negotiated or fixed value.

## Importing rates

- **On demand.** The Exchange rates collection page has a **Run import** action
  that fetches the latest remote rates immediately.
- **Automatically.** Remote providers also import on **cron**, throttled by the
  refresh/cron settings you chose above. Make sure cron runs regularly so rates
  stay current.

Manual sources have nothing to import — you maintain their rates directly.

## Which source is used for conversion

When code converts a price, the calculator uses the **first enabled** provider.
If you run several sources side by side, make sure the one you want to be
authoritative is the enabled/first one, and disable or order the others
accordingly.

## Displaying a converted price

To show a price converted into another currency on the front end, edit the
relevant entity's **Manage display** and set the price field's formatter to
**Converted price** (`commerce_price_exchanger`). Its settings let you choose:

- **Target currency** — the currency to convert into.
- **Currency display** — how the currency is shown (symbol, code, etc.).
- **Strip trailing zeroes** — tidy up amounts like `10.00`.

This is a common way to show a secondary "approximately X USD" price next to the
primary currency on a product page.

## For developers

- Convert a price in code with the `commerce_exchanger.calculate` service
  (`priceConversion($price, 'USD')`).
- Read or write rates directly with the `commerce_exchanger.manager` service.
- Add a custom remote provider (for example a national bank) by writing a
  `commerce_exchanger_provider` plugin.

See the agent docs for details:
[`api/services.md`](../../agent/api/services.md) and
[`plugins/provider.md`](../../agent/plugins/provider.md).
