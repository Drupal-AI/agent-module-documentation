<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_product_type_fees — agent start

Adds **configurable percentage fees per Drupal Commerce product type**. An admin defines one or more
named percentage fees for each `commerce_product_type`; at order refresh a Commerce **order processor**
turns each fee into a positive **`custom_fee` adjustment** on the order, computed server-side from the
order subtotal. Version **3.1.2**. Core `^9 || ^10 || ^11`. Depends on `commerce`, `commerce_order`,
`commerce_product`; Composer requires `drupal/commerce:~3.0`.

## Moving parts (all source, no other files)

- **`src/FeesOrderProcessor.php`** — `OrderProcessorInterface` service
  `commerce_product_type_fees.fees_order_processor`, tagged `commerce_order.order_processor` at
  **priority 300** (`*.services.yml`, ctor arg `@config.factory`). `process(OrderInterface $order)`
  determines whether the order contains a product type that has configured fees (`<type>_fees` key in
  config), and if so reads `$order->getSubtotalPrice()` and, for each configured fee with a non-empty
  `percentage`, computes `subtotal * (percentage/100)` (`sprintf("%.2f", …)`) and adds a positive
  adjustment via `addFee()` →
  `Adjustment(['type' => 'custom_fee', 'label' => $fee['fee']['label'], 'amount' => Price])`. Rate and
  label come **only** from `commerce_product_type_fees.settings` config (admin-set), never from the
  request; the form's `#min 0 / #max 100` keeps percentages non-negative, so adjustments are additive,
  not discounts. Adjustments are recomputed on each order refresh.
- **`src/Form/FeesSettingsForm.php`** — `ConfigFormBase` (`getFormId` `commerce_product_type_fees_settings`,
  editable config `commerce_product_type_fees.settings`). Renders one `details` section per
  `commerce_product_type` (loaded via `entity_type.manager`), each holding an AJAX table of fee rows:
  a `textfield` **Name/label** (maxlength 255, required — `validateForm` rejects empty labels) plus a
  `commerce_number` **percentage** (`#min 0`, `#max 100`, `%` suffix). Add/Remove are AJAX submit
  handlers (`addFeeSubmit`/`removeFeeSubmit`/`ajaxCallback`) that mutate a `<type>_fees` array in form
  state; each fee gets a generated UUID (`@uuid`). `submitForm` saves only rows with a fee id back to
  config under `<type>_fees`.
- **`commerce_product_type_fees.commerce_adjustment_types.yml`** — declares the **`custom_fee`**
  adjustment type (label "Fee", `has_ui: true`, weight 0) that the processor emits.
- **`*.routing.yml`** — `commerce_product_type_fees` (menu block at `/admin/config/commerce_product_type_fees`)
  and `commerce_product_type_fees.settings` (the form at
  `/admin/commerce/config/commerce_product_type_fees/settings`). **Both require permission
  `access commerce administration pages`.** No custom permission is defined.
- **`*.module`** — only `hook_help()`. **`*.links.menu.yml` / `*.links.task.yml`** — admin menu/tab
  entries under Commerce → Configuration → Fees.

## Config shape

`commerce_product_type_fees.settings` holds one key per product type: `<product_type_id>_fees`, a list of
`{ fee: { id: <uuid>, label: <string> }, percentage: <number 0-100> }`. There is **no config schema
file** shipped (no `config/schema/`), and no default config, `.install`, JS, or templates.

## Notes for agents

- Fees are proportional to the order **subtotal**, applied on every order refresh; they are pure
  configuration output, computed server-side. No API keys, tokens, or external calls.
- `FeesOrderProcessor::create()` exists but is unused (the service is built from `services.yml`
  arguments) and its `ContainerInterface` type hint is unimported — harmless dead code.

See `../usage.md` and `../human-docs/` for task-oriented guidance.
