# Configuration

Currency is a suite of related admin screens, all under **Configuration → Regional
and language**. The usual order of setup is: **import the currencies you trade in**,
optionally **adjust the formatting**, then **set up exchange rates** if you need
conversion, and finally **enable the editor filters** if you want money handling in
text. Each area has its own permission, so you can hand out fine-grained access.

## 1. Import the currencies you need

A fresh install has only the placeholder `XXX` currency enabled — the real ones are
imported from a bundled data library.

1. Go to **Configuration → Regional and language → Currency**
   (`/admin/config/regional/currency`).
2. Click **Import** (`/admin/config/regional/currency/import`).
3. Choose the currency to add (USD, EUR, GBP, …) and import it. Repeat for each
   currency your site uses.

You can also:

- **Add a custom currency** at `/admin/config/regional/currency/add` — useful for a
  loyalty-point, voucher, or in-game currency. You give it a code, number, label,
  sign, subunits (minor units per major unit, e.g. 100 cents), and a rounding step.
- **Edit** an existing currency to change its sign, subunits, alternative signs, or
  rounding step (for example the Swiss franc's 0.05 rounding).
- **Enable or disable** individual currencies so only the ones you trade in appear.

## 2. Formatting: locales and the default formatter

**Formatting locales** control how amounts are punctuated — the decimal separator,
the grouping separator, and the display pattern. The `en_US` locale ships enabled
(`.` for decimals, `,` for grouping). Manage them at
`/admin/config/regional/currency-formatting/locale`, where you can add or import
more (for example `de_DE`, which swaps the separators). The right locale for the
current language and country is chosen automatically when an amount is formatted.

> **Handle locale patterns with care.** Editing a locale's pattern changes how
> *every* amount on the site is rendered, which is why the create/edit locale
> permissions are marked as restricted. Grant them only to trusted administrators.

**The default amount formatter** decides the overall display style. Go to
**Configuration → Regional and language → Currency amount formatting**
(`/admin/config/regional/currency-formatting`) and choose the formatter to use site
wide. The module ships a basic formatter (which prepends the sign/code and applies
the locale's separators); developers can add their own formatter plugins and select
them here.

## 3. Exchange rates and conversion

Conversion is done by **exchange rate provider** plugins, stacked and queried in
order (the first provider that can supply a currency pair wins).

**Choose and order the providers:**

1. Go to **Configuration → Regional and language → Currency exchange**
   (`/admin/config/regional/currency-exchange`).
2. Enable the providers you want and order them. Two ship:
   - **Fixed rates** — rates you enter by hand.
   - **Historical rates** — rates bundled with the exchange library.

**Enter fixed rates:**

1. Go to `/admin/config/regional/currency-exchange/fixed`.
2. Add a rate by choosing the *from* and *to* currencies and the rate value — for
   example EUR → USD = `1.25`. Edit or delete rates from the same screen.

> **Define a rate before you convert.** If no enabled provider can supply a
> requested currency pair, conversion fails rather than returning nothing. Make sure
> a fixed or historical rate exists for any pair you plan to convert. (The editor
> `currency_exchange` filter handles a missing rate gracefully by leaving the
> original token in place.)

## 4. Editor filters (optional)

Two text-format filters let content editors work with money directly in body text.
Enable them per text format at **Configuration → Content authoring → Text formats
and editors** (`/admin/config/content/formats`), on the formats where you want them:

- **Currency exchange** — converts an amount inline with the token
  `[currency:FROM:TO:amount]`, e.g. `[currency:EUR:USD:100]` (the amount is optional
  and defaults to 1).
- **Currency localize** — formats monetary amounts found in the text using the site's
  amount formatter.

## Permissions

Currency ships a granular permission for each area — grant only what each role
needs:

| Permission | Lets a role… |
|------------|--------------|
| **View currencies** (`currency.currency.view`) | see the currencies list |
| **Add/import currencies** (`currency.currency.create`) | add or import currencies |
| **Edit currencies** (`currency.currency.update`) | edit, enable, and disable currencies |
| **Delete currencies** (`currency.currency.delete`) | delete currencies |
| **View currency locales** (`currency.currency_locale.view`) | see the formatting locales |
| **Add/import currency locales** (`currency.currency_locale.create`) | add/import locales — *restricted* |
| **Edit currency locales** (`currency.currency_locale.update`) | edit locale patterns — *restricted* |
| **Delete currency locales** (`currency.currency_locale.delete`) | delete locales |
| **Administer amount formatting** (`currency.amount_formatting.administer`) | choose the default formatter |
| **Administer exchange rate providers** (`currency.exchange_rate_provider.administer`) | enable/order providers |
| **Administer fixed rates** (`currency.exchange_rate_provider.fixed_rates.administer`) | add/edit/delete fixed rates |

Grant a permission from the UI at **People → Permissions**, or with Drush, e.g.:

```bash
drush role:perm:add editor 'currency.currency.view'
```

## For developers

Currency exposes a `currency_amount` form/render element and a `Currency::formatAmount()`
method for displaying amounts, plus two plugin types you can extend — custom amount
formatters and custom exchange rate providers (for example, live rates from an API).
Those developer topics are covered in the [`agent/`](../agent/start.md) docs.
