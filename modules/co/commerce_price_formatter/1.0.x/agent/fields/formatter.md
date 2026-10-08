# Discount display on the Calculated price formatter

This module does **not** register a field formatter. It attaches to Commerce's existing
**`commerce_price_calculated`** formatter (from `commerce_product`, applied to the `commerce_price`
field, typically the variation's `price` field) through third-party settings and a preprocess hook.
All code lives in `commerce_price_formatter.module`.

## Enabling it (UI)

*Administration → Commerce → Configuration → Product variation types → (a type) → Manage display*
(`entity.entity_view_display.commerce_product_variation.default`). Set the **Price** field's Format to
**Calculated price** (`commerce_price_calculated`), open its formatter settings gear, and tick
**"Enable discount format for calculated price"**. The *Manage display* summary then shows
`Discount format is enabled.`

The flag is stored as `third_party_settings.commerce_price_formatter.commerce_price_formatter = true`
on that formatter component. Enable it from code:

```php
$display = \Drupal::service('entity_display.repository')
  ->getViewDisplay('commerce_product_variation', 'default', 'default');
$component = $display->getComponent('price');
$component['type'] = 'commerce_price_calculated';
$component['third_party_settings']['commerce_price_formatter']['commerce_price_formatter'] = TRUE;
$display->setComponent('price', $component)->save();
```

## The two settings hooks (`commerce_price_formatter.module`)

- `hook_field_formatter_third_party_settings_form` (`:31`) — only when
  `$plugin->getPluginId() == 'commerce_price_calculated'`, adds a bold label and a `checkbox`
  `commerce_price_formatter` (title "Enable discount format for calculated price"), default from the
  formatter's existing third-party setting.
- `hook_field_formatter_settings_summary_alter` (`:19`) — for the same plugin id, appends
  `Discount format is enabled.` to the *Manage display* summary when the setting is on.

## Render path — `hook_preprocess_commerce_price_calculated` (`:60`)

Runs on every render of the `commerce_price_calculated` theme hook. Steps:

1. Reads `$variables['purchasable_entity']` and calls
   `EntityViewDisplay::collectRenderDisplay($entity, 'default')` — **the view mode is hardcoded to
   `'default'`** — then `getComponent('price')`.
2. Proceeds only if that component's
   `third_party_settings['commerce_price_formatter']['commerce_price_formatter']` is truthy.
3. `basePrice = $variables['result']->getBasePrice()->getNumber()`,
   `calculatePrice = $variables['result']->getCalculatedPrice()->getNumber()`
   (the `result` is Commerce's calculated-price result; the calculated price already has promotions
   from `commerce_promotion` applied).
4. Discount % (only if `basePrice != (int) $calculatePrice`):
   `round((($basePrice - $calculatePrice) / $basePrice) * 100) . '%'`.
5. Builds `$content = ['base_price' => round($basePrice, 2), 'calculated_price' => $calculatePrice,
   'applied_discount' => $appliedDiscount]`.
6. If `basePrice != $calculatePrice`: overwrites `$variables['calculated_price']` with a render array
   `['#theme' => 'commerce_price_formatter', '#viewData' => $content]`, adds cache tag
   `commerce_product_variation:<id>`, and attaches library `commerce_price_formatter/format`.

## Theme + template

`hook_theme` (`:49`) registers `commerce_price_formatter` with variable `viewData`. Template
`templates/commerce-price-formatter.html.twig`:

```twig
<strong>{{ viewData.calculated_price }}</strong>
<strike>{{ viewData.base_price }}</strike>
<span>({{ viewData.applied_discount }} {{ 'off'|t }})</span>
```

## Behavioral notes / gotchas (real, from source)

- **Numbers are raw, not currency-formatted.** The template prints `calculated_price` and `base_price`
  as bare numbers (e.g. `40` / `50.00`) with **no currency symbol** — it bypasses Commerce's normal
  price formatting.
- **Only the `default` view display's flag is honoured.** Because step 1 hardcodes `view_mode =
  'default'`, enabling the checkbox on a non-default display has no effect, and enabling it on `default`
  affects the price wherever the `commerce_price_calculated` formatter is rendered.
- **Two different comparisons.** The percent is computed under `basePrice != (int) $calculatePrice`
  (integer cast) but the replacement render happens under `basePrice != $calculatePrice`; for a whole
  base price with a fractional calculated price you can get the strikethrough with an empty
  `applied_discount`.
- The CSS in `css/style.css` targets classes (`.pdp-mrp-verbiage-amt-wrapper`, `.percent-off`, …) that
  the shipped template does not emit, so styling is effectively inert until you override the template.
- After changing promotions or display config, **clear cache** (README) — the price render is cached
  per `commerce_product_variation:<id>`.
