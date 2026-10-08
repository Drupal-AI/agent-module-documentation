# Configuration

Commerce Currency Resolver is configured on one main settings form, plus the mapping
pages added by whichever resolver submodules you enabled. This page covers the core
settings; the submodules' mapping pages (language‑to‑currency, country‑to‑currency)
follow the same pattern and use the same permission.

## Open the settings form

1. Log in as a user with the **Administer currency settings** permission.
2. Go to **Commerce → Configuration → Store → Currency resolver**
   (`/admin/commerce/config/commerce_currency_resolver/settings`).

## Currency source

This is the central choice — how the module works out each price in the visitor's
currency:

- **Field** — prices come only from dedicated per‑currency price fields you add to your
  products (see below). If a product has no field for the resolved currency, the module
  leaves the price to Commerce's normal fallback.
- **Auto** — every price is converted from your store's default currency using live
  exchange rates from Commerce Exchanger. No per‑currency fields are needed.
- **Combo** — the best of both: use a per‑currency field where one exists, and
  automatically convert where it doesn't. This is the typical default once automatic
  conversion is available.

> **Note:** the base form only offers the **Field** option on its own. The **Auto** and
> **Combo** options — and the exchange‑rate provider selector — appear only once the
> **Exchanger** submodule is enabled. If you want automatic conversion, enable that
> submodule first (see [Installation](../installation/index.md#submodules--enable-only-what-you-need)).

## Currency field prefix

When you use **Field** or **Combo** mode, the module looks for a price field named from
a prefix plus the lowercase currency code. The default prefix is **`field_price_`**, so
the Euro price lives in `field_price_eur`, the GBP price in `field_price_gbp`, and so
on. Change the prefix here if your fields already follow a different naming scheme.

## Exchange‑rate provider (auto / combo only)

When automatic conversion is in play, this setting picks which **Commerce Exchanger**
provider supplies the rates. Configure your exchanger provider(s) in Commerce
Exchanger's own settings first, then select the one to use here.

Click **Save configuration** when you're done.

## Adding per‑currency price fields

For **Field** and **Combo** modes you supply a price per currency by adding fields to
your purchasable entity — usually the **product variation**:

1. Go to the variation type's **Manage fields**
   (e.g. **Commerce → Configuration → Product variation types → [type] → Manage
   fields**).
2. Add a **Price** field for each non‑default currency, named `{prefix}{code}` with the
   currency code in lowercase — for example `field_price_eur`, `field_price_gbp`.
3. Enter the appropriate amount in each field when editing a product.

You do **not** need a field for your store's default currency — that is the product's
normal base price.

## Caching requirement (don't skip this)

The module varies content per currency using its own cache context and works only with
Drupal's **Internal Dynamic Page Cache**. The core **Page Cache** module must be
**disabled** — otherwise it will cache one currency's pages and serve them to every
visitor regardless of their resolved currency. If you haven't already:

```bash
drush pmu page_cache -y
```

## Choosing the visitor's currency (submodules)

The settings above decide how prices are *calculated*; the resolver submodules decide
*which* currency each visitor gets:

- **Cookie** — remembers the shopper's own selection (pair it with the currency‑switcher
  block, placed via **Structure → Block layout**).
- **Language** — maps each interface language to a currency on the submodule's mapping
  page.
- **GeoIP / Smart IP** — maps the visitor's detected country to a currency on the
  submodule's mapping page.

Each submodule's mapping page appears under the same **Currency resolver** area and is
gated by the same **Administer currency settings** permission. When you enable more than
one resolver, they run in priority order (cookie first, then GeoIP/Smart IP, then
language), and the first to return a currency wins.
