<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Better Product Variation Label (commerce_better_product_variation_label) — agent index

Improves the generated **label/title** of Drupal Commerce product variations. Its one shipped feature:
optionally **prefix a variation's label with its parent product's label**, configured per
product-variation type. Also exposes a `:label` token for `commerce_product_variation`. Package
`Commerce`. Core `^10.3 || ^11`. License GPL-2.0-or-later. Installed **1.0.0-beta2** (version dir `1.0.x`).

Note: it does NOT build titles from attribute values or a pattern — the only transformation is the
parent-product-label prefix. The README lists other ideas as "TBI"/future.

## Dependencies

- Drupal module: **`commerce:commerce_product`** (`.info.yml`).
- Composer: **`drupal/commerce` `^2 || ^3`** (`composer.json`). No PHP libraries.

## What it provides (from source)

- **Entity class override** (`commerce_better_product_variation_label.module`,
  `hook_entity_type_alter`): swaps the `commerce_product_variation` entity class for
  `src/Entity/ProductVariation.php` (extends `Drupal\commerce_product\Entity\ProductVariation`).
- **`ProductVariation::label()`**: if the variation type's third-party setting
  `product_label_prefix` is enabled AND the variation has a parent product AND the parent's label
  differs from the default variation label, returns `parentProduct->label() . $separator .
  parentLabel`; otherwise falls back to `parent::label()`. `$separator` comes from third-party
  setting `product_label_prefix_separator` (default `' '`).
- **Config UI** (`hook_form_commerce_product_variation_type_form_alter` + submit handler): adds a
  collapsed "Commerce Better Product Variation Label settings" details fieldset to the
  **product variation type** edit form with a checkbox `product_label_prefix` and a required textfield
  `product_label_prefix_separator`. Values are stored as third-party settings on the
  `commerce_product_variation_type` config entity (schema in
  `config/schema/commerce_better_product_variation_label.schema.yml`).
- **Token** (`hook_token_info` / `hook_tokens`): defines `[commerce_product_variation:label]`,
  which returns `$variation->label()` (i.e. the improved label). Use it instead of `:title` where a
  token pattern should reflect the generated label.

## What it does NOT provide

- No permissions of its own — the config lives on the variation-type form, gated by that form's own
  access (`administer commerce_product_variation_type`).
- No services, routes, controllers, blocks, templates, libraries, or Drush commands.
- No settings page (config is per variation type). `.install` file is empty (no install/update hooks).

## Configuration path

Structure → Commerce → Product variation types → *(edit a type)* → "Commerce Better Product
Variation Label settings".
