<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Configurable Order Total (commerce_configurable_order_total) — agent index

A **display-only** enhancement for Drupal Commerce: it renders the order-total summary
(subtotal, adjustment lines, grand total) with per-instance toggles for which lines appear and
whether prices show trailing zeroes. Nothing here recalculates or changes the charged total — it
only re-presents what Commerce's own `commerce_order.order_total_summary` service already computed.
Package `Commerce`. Core `^11` (installed **1.0.1**, version dir `1.0.x`). License GPL-2.0-or-later.

## Dependencies

- Drupal modules: **`commerce`** (Drupal Commerce) — the only dependency (`.info.yml`).
- No PHP libraries, no Composer requirements beyond `drupal/core: ^11` (`composer.json`).
- Uses Commerce's `commerce_order.order_total_summary` service and the `commerce_price` field type;
  a working install therefore also has `commerce_order` / `commerce_price` present via Commerce.

## What it provides (from source)

- **Views area handler** `commerce_configurable_order_total`
  (`src/Plugin/views/area/ConfigurableOrderTotalArea.php`, `#[ViewsArea]`). Registered as Views data
  in `src/Hook/Hooks.php` (`hook_views_data`). This is the primary, intended surface — drop it into
  a View's Footer (replacing Commerce's own "Order total" area). It reads the View's Order ID
  argument, loads the order, and renders its `total_price` through the field formatter below.
- **Field formatter** `commerce_configurable_order_total_summary`
  (`src/Plugin/Field/FieldFormatter/ConfigurableOrderTotalSummary.php`, `#[FieldFormatter]`) for the
  `commerce_price` field type; `isApplicable()` restricts the UI to the `commerce_order.total_price`
  field. It injects `commerce_order.order_total_summary`, calls `buildTotals($order)`, and hands the
  result to the theme hook.
- **Theme hook + template** `commerce_configurable_order_total_summary`
  (`hook_theme` in `src/Hook/Hooks.php`; `templates/commerce-configurable-order-total-summary.html.twig`).
  Themeable; override by copying the template into a theme's
  `templates/commerce_configurable_order_total/` folder.
- **Config schema** `views.area.commerce_configurable_order_total`
  (`config/schema/commerce_configurable_order_total.schema.yml`) — the four boolean options.
- **hook_help** for `help.page.commerce_configurable_order_total` (About + one-line config note).
- **No** permissions file, **no** services.yml (hooks are attribute-based via `src/Hook/Hooks.php`),
  **no** install/update hooks, **no** Drush commands, **no** admin/config route.

## The four options (identical on the area handler and the formatter)

`disable_subtotal`, `disable_adjustments`, `disable_totals`, `strip_trailing_zeroes` — all booleans,
all default `FALSE`. They toggle which of the three summary blocks render and whether prices are
formatted with `minimum_fraction_digits: 0`. Purely presentational; see the subdoc.

## Test-only submodule

`tests/modules/commerce_configurable_order_total_test/` is a **test fixture** (a `views.view.*`
config that wires the area into a "Checkout order summary" test view). Not for production; no
separate doc.

## Solution docs

- **Area handler render flow, field formatter, options, theming** →
  [config/display-options.md](config/display-options.md)
