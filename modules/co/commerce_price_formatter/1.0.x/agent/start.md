<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Price formatter (commerce_price_formatter) — agent index

Adds a **strikethrough "was / now + percent off"** display to Commerce's existing **Calculated price**
field formatter (`commerce_price_calculated`, from `commerce_product`). It provides no formatter of its
own. Instead four hooks in `commerce_price_formatter.module` bolt onto the core Commerce formatter: a
**third-party settings checkbox** ("Enable discount format for calculated price") is added to that
formatter's *Manage display* settings, and when it is checked the module's `preprocess` of the
`commerce_price_calculated` theme hook compares the variation's **base price** to its **calculated
(promotion-applied) price**, computes a rounded percent difference, and replaces the rendered price
with a small template showing the discounted price, the struck-through base price and the "% off".

The whole surface is: one theme hook + Twig template, one CSS library, and the two formatter-settings
hooks. There are **no routes, controllers, services, forms, permissions, plugin types, config schema,
or drush commands**. The discount only renders when the `price` component on the variation's **`default`
view display** has the third-party flag enabled (the preprocess hardcodes `view_mode = 'default'` when it
reads the display component) and when `basePrice != calculatedPrice`.

- Depends on: `commerce:commerce`, `commerce:commerce_product`, `commerce:commerce_promotion`
  (composer requires `drupal/commerce:^2.40 || ^3`). The base price/calculated price come from the
  Commerce price **calculator** (promotions resolved via `commerce_promotion`).
- Core: `^9 || ^10 || ^11`. Package: `Commerce`. Version **1.0.1**.
- No settings page / `configure` route — configured **per field formatter** on *Manage display*.
  No permissions, no drush, no plugin types, no config schema of its own.

## What you'd do → where

- **Turn the discount display on for a product variation / how the base-vs-calculated math and the
  template work / the `default`-view-mode gotcha** → [fields/formatter.md](fields/formatter.md)

## Key facts (real machine names)

- Extends (does not define) formatter plugin id **`commerce_price_calculated`** via third-party settings.
- Third-party settings provider/key: **`commerce_price_formatter` / `commerce_price_formatter`** (a
  boolean checkbox) on that formatter's `third_party_settings`.
- Hooks (all in `commerce_price_formatter.module`): `hook_field_formatter_third_party_settings_form`,
  `hook_field_formatter_settings_summary_alter`, `hook_theme`,
  `hook_preprocess_commerce_price_calculated`.
- Theme hook: **`commerce_price_formatter`** (variable `viewData`), template
  `templates/commerce-price-formatter.html.twig` (renders `viewData.calculated_price`,
  `viewData.base_price`, `viewData.applied_discount`).
- Library: **`commerce_price_formatter/format`** (`css/style.css`, dep `core/drupalSettings`).
- Cache tag added when rendering: `commerce_product_variation:<id>`.
- CSS classes in the stylesheet: `.pdp-mrp-verbiage-amt-wrapper`, `.pdp-mrp`, `.percent-off`,
  `.inc-taxes` (note: the shipped template does not actually emit these class names).
