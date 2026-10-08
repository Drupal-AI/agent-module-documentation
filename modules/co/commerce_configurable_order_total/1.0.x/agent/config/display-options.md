<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display options, render flow & theming

All source paths are relative to
`web/modules/contrib/commerce_configurable_order_total/`.

## Where the options live

Four booleans, all default `FALSE`, declared in three places that must stay in sync:

| Option | Effect |
|---|---|
| `disable_subtotal` | Hides the subtotal line. |
| `disable_adjustments` | Hides every adjustment line (tax, shipping, promotion, fee, …). |
| `disable_totals` | Hides the grand-total line. |
| `strip_trailing_zeroes` | Formats prices with `commerce_price_format({'minimum_fraction_digits': 0})` (e.g. `$10.00` → `$10`). |

- **Area handler**: `ConfigurableOrderTotalArea::defineOptions()` + `buildOptionsForm()`
  (`src/Plugin/views/area/ConfigurableOrderTotalArea.php`). Set in the Views UI on the area instance.
- **Field formatter**: `ConfigurableOrderTotalSummary::defaultSettings()` + `settingsForm()`
  (`src/Plugin/Field/FieldFormatter/ConfigurableOrderTotalSummary.php`). Set in the field-display UI.
- **Config schema**: `views.area.commerce_configurable_order_total`
  (`config/schema/commerce_configurable_order_total.schema.yml`).

## Render flow (area handler → formatter → template)

1. `ConfigurableOrderTotalArea::render($empty)` runs only when not empty (or when the area's own
   `empty` option is set). It iterates `$this->view->argument`, keeping only a `NumericArgument`
   whose field is one of `commerce_order.order_id`, `commerce_order_item.order_id`, or
   `commerce_payment.order_id`.
2. It loads the order: `$this->orderStorage->load($argument->getValue())` (storage from
   `entity_type.manager`). If no order loads, it returns `[]` (renders nothing — matching the form
   help text: "this area handler will never render if a valid order cannot be found").
3. It renders the order's `total_price` field with the module's formatter:
   `$order->get('total_price')->view(['type' => 'commerce_configurable_order_total_summary', 'label' => 'hidden', 'settings' => [...the four options...]])`,
   then wraps it in `<div data-drupal-selector="order-total-summary">…</div>`.
4. `ConfigurableOrderTotalSummary::viewElements()` builds a render array with
   `#theme => 'commerce_configurable_order_total_summary'`, passing `#order_entity`, the four option
   flags, and **`#totals => $this->orderTotalSummary->buildTotals($order)`** — the totals come from
   Commerce's own `commerce_order.order_total_summary` service. The formatter does not compute or
   alter any amount. Renders nothing when the field item list is empty.
5. `templates/commerce-configurable-order-total-summary.html.twig` renders three optional blocks
   (subtotal, a `for` loop over `totals.adjustments`, total), each gated by the matching
   `disable_*` flag and formatted per `strip_trailing_zeroes`. It attaches
   `commerce_order/total_summary` for styling.

`buildTotals()` returns keys `subtotal`, `adjustments` (each with `type`, `label`, `amount`,
`percentage`), and `total`.

## Output & escaping

- The template auto-escapes: `{{ 'Subtotal'|t }}`, `{{ 'Total'|t }}`, `{{ adjustment.label }}`,
  and the `commerce_price_format`-filtered amounts. There is **no `|raw`** anywhere.
- Adjustment labels originate from Commerce's computed adjustments (tax/promotion/shipping labels),
  rendered through Twig auto-escaping.

## Theming

Override by copying `commerce-configurable-order-total-summary.html.twig` into a theme's
`templates/commerce_configurable_order_total/` directory. Available variables (from `hook_theme` in
`src/Hook/Hooks.php` and the template docblock): `order_entity`, `totals`, `disable_subtotal`,
`disable_adjustments`, `disable_totals`, `strip_trailing_zeroes`, `description`, plus `attributes`.

## Typical setup

Edit the **Checkout order summary** view → **Footer** → remove Commerce's **Order total** area →
add **Commerce Configurable Order Total** → set the four options. The view must expose an Order ID
contextual argument for the handler to resolve an order (see the test fixture
`tests/modules/commerce_configurable_order_total_test/test_views/views.view.commerce_checkout_order_summary_test.yml`
for a complete working example).
