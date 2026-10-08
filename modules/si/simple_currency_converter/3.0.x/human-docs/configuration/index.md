# Configuration

Simple Currency Converter needs a short configuration pass before it does anything.
The essentials are: choose a rate feed, tell the module which elements on the page
are prices, and pick a base currency.

## Open the settings form

1. Log in as a user with the **Administer simple currency converter** permission.
2. Go to **Configuration → Regional and language → Simple Currency Converter**, or
   navigate directly to `/admin/config/regional/simplecurrencyconverter`.

## The main settings

- **Price selector** (`conversion_selector`) — a CSS selector matching the price
  elements rendered on your pages. This is the most important setting: if the
  selector does not match your prices, nothing gets converted. Set it to whatever
  wraps your prices (for example a class your theme puts on price output).
- **Primary feed** (`feed_primary`) — the exchange‑rate feed to use, chosen from the
  feeds provided by the submodules you enabled (ECB, FloatRates, or a custom one).
- **Secondary feed** (`feed_secondary`) — an optional fallback feed used when the
  primary returns no rate.
- **Default / base currency** (`default_conversion_currency`) — the currency your
  prices are stored in, i.e. the currency conversions start *from*.
- **Rate storage** (`default_storage`) — whether fetched conversion ratios are
  cached in Drupal's cache backend or in a cookie.
- **Rate lifetime** (`conversion_rate_lifetime`) — how long, in seconds, a fetched
  rate stays valid before it is refreshed.

## The currency picker dialog

A group of settings controls the picker visitors use to choose a currency:

- **Trigger** (`window_trigger`) and **window id** (`window_id`) — how and where the
  picker is opened on the page.
- **Dialog title** (`window_title`) — the heading shown on the picker.
- **Disclaimer** (`disclaimer`) — optional text shown in the dialog, e.g. a note
  that converted prices are indicative.

## Save

Click **Save configuration**. Reload a page with prices and open the picker to
check the conversion works. If prices do not change, re‑check your CSS selector
first.

## FloatRates feed settings

If you enabled the FloatRates submodule (`floatrates_scc`), it has its own form at
`/admin/config/regional/simplecurrencyconverter/floatrates` (permission **Administer
Floatrates settings**), where you set its feed URL. The ECB submodule
(`ecb_scc`) needs no configuration — its feed URL is fixed.

## How conversion works at runtime

When a visitor picks a currency, the page calls
`/simple_currency_converter_set_currency/{from}/{to}`, which asks the selected feed
for a rate and returns it as JSON, caching it per your storage and lifetime
settings. This endpoint is open to anonymous visitors **by design** so anyone can
switch currency; it returns only a numeric rate and never fetches a URL you supply.

## Add your own feed (developers)

To register a custom rate source, implement
`Drupal\simple_currency_converter\CurrencyConverter\CurrencyConverterInterface`
(its `convert()` and `currencies()` methods) and register it as a service. A
compiler pass collects it automatically, after which it becomes selectable as a
primary or secondary feed in the settings form above.
