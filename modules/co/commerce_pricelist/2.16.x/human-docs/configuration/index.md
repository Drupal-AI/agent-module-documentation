# Configuration

Commerce Pricelist has no traditional "settings" form. You configure it by
**creating price lists and adding prices to them** through the admin UI. This page
walks through that workflow field by field.

Everything requires the **Administer commerce pricelist**
(`administer commerce_pricelist`) permission, which administrators have by default.
Entity API also generates per‑bundle permissions if you need finer control.

## Step 1 — Create a price list

1. Go to **Commerce → Price lists** (`/admin/commerce/price-lists`).
2. Click **Add price list** (`/price-list/add`). If you have more than one
   price‑list type, pick the purchasable‑entity type first — the default is
   **Product variation**.

Fill in the price list's fields:

- **Name** — a label for the list, for example "Wholesale" or "Summer sale". This
  is for your reference only; customers never see it.
- **Stores** — limit the list to one or more stores. Leave empty to apply it to
  every store.
- **Customers** — limit the list to specific customer accounts (individual users).
  Leave empty for no per‑customer restriction. This is how you give one B2B
  customer their own negotiated pricing.
- **Customer roles** — limit the list to everyone in the chosen roles, for example
  a "wholesale" or "member" role.
- **Start date** / **End date** — the optional window during which the list is
  active. Use these for time‑limited promotions or to schedule a future price
  change by pre‑creating a list with a start date.
- **Weight** — the priority used when several lists match the same shopper and
  product at once; you can also reorder lists by dragging them in the collection
  view. Lower/earlier wins.
- **Enabled** — a checkbox to switch the whole list on or off without deleting it.

Save the list. Remember that a list with *no* conditions applies to everyone, in
every store, at all times.

## Step 2 — Add prices to the list

Open the list and go to its **Prices** collection
(`/price-list/{id}/prices`), then click **Add price**. Each price row has:

- **Purchasable entity** — the product variation this price applies to.
- **Quantity** — the minimum quantity at which this price kicks in. Use this for
  tiered pricing: add one row at quantity 1 and another at quantity 10 for a
  cheaper bulk unit price.
- **Price** — the actual amount (and currency) the shopper pays when this list
  wins.
- **List price** — an optional MSRP or "was" price you can show struck through
  alongside the real price.
- **Enabled** — switch a single price row on or off without deleting it.

You can also add a price to a variation directly from the product, at
`/product/{product}/variations/{variation}/prices/add`.

## Step 3 — Bulk import / export with CSV

For large catalogs, skip the one‑by‑one forms:

- **Import** — from a list's Prices collection choose **Import**
  (`/price-list/{id}/prices/import`) to bulk‑load prices from a CSV file. The module
  ships a `sample_file.csv` showing the expected columns.
- **Export** — choose **Export** (`/price-list/{id}/prices/export`) to download the
  list's current prices as CSV, edit them in a spreadsheet, and re‑import.

## How the winning price is chosen

You never wire anything up for this to work. When a product's price is calculated
(at add‑to‑cart or on the product page), the module checks every **enabled** price
list whose conditions — store, customer, customer roles, date window — match the
current shopper and context, orders them by weight, and for the winning list picks
the price row whose quantity threshold fits. That price then overrides the
variation's normal base price. If nothing matches, the ordinary price applies.

## Managing lists over time

From the price‑list collection you can **edit**, **duplicate** (a quick way to base
a new scheme on an existing one), **enable/disable**, **delete**, and **reorder**
lists. Duplicating plus adjusting conditions is the fastest way to build seasonal or
region‑specific pricing.
