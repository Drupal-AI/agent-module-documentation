# Configuration

> The screens below are described from the module's source and install metadata.
> In the environment where these docs were produced, Basket could not be enabled
> on a bare Drupal 11.4 site, so the runtime UI was not verified live. Treat exact
> paths and labels as a guide and confirm them on your own site.

Basket keeps its administration on the module's own paths (under the **Online
store** package), not on the usual Drupal Commerce paths.

## Orders

Order management is the heart of the admin area: orders are entities with their
own admin screens where your team views orders, changes their status, and works
through fulfilment. Which fields appear in the order filter is itself
configurable, so you can tune the order list to how your shop works.

## Permissions (finer‑grained than most shops)

Basket's permissions are grouped by area (Orders first) and split more finely
than a typical Drupal store. Notably, order rights are separated so you can grant
them independently:

- View orders.
- Edit an order's **status**.
- Edit an order's **financial status** — a *separate* permission from editing the
  ordinary status.
- Configure the order filter fields.

That separation is deliberate: you can let a fulfilment person move orders through
their workflow (edit status) without giving them the ability to change the money
side (edit financial status). Assign these at **People → Permissions**.

## Currencies

The store supports **multiple currencies** through its own currency handling, so
you can run a shop in more than one currency.

## Scheduled maintenance (cron) and export

- Scheduled store work runs through **cron** — make sure Drupal cron runs
  regularly.
- Order data can be **exported** (for example for accounting) through the
  module's export feature.

## Styling depends on scss_compiler

The storefront CSS is compiled from Sass at request time by the separate
`scss_compiler` module. If the shop renders unstyled, the first thing to check is
that `scss_compiler` is installed, enabled and working.

## Adding payment and delivery

Payment and carrier integrations are separate companion modules that plug into
Basket — for example **Basket PayPal** (`basket_paypal`) for PayPal, and a Nova
Poshta delivery module. Install the ones you need, then configure each in its own
settings (for payment gateways, keep API credentials out of committed
configuration — see that module's own guide).
