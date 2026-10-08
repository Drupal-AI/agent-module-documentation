<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Product Availability — field type, widgets, formatter, tokens

## Field type `commerce_product_availability_product_availability`

`src/Plugin/Field/FieldType/ProductAvailabilityItem.php` (extends `FieldItemBase`,
category `commerce`). Add it to a `commerce_product_variation` bundle
(Manage fields → the **Commerce** section).

Stored columns / properties:

| property | type | notes |
|---|---|---|
| `orderable` | boolean (int tiny, `not null`) | the ONLY value that governs purchasability |
| `availability_status` | string varchar(64), **required** | `in_stock` / `out_of_stock` / `preorder` / `backorder` (alterable) |
| `availability_date_value` | datetime_iso8601 (varchar 20) | "Available from" date |
| `min_delivery_period` | integer | |
| `max_delivery_period` | integer | |
| `availability_status_schemaorg` | string, **computed** | schema.org URL, see below |
| `availability_date_object` | computed `DateTimeComputed` | derived from `availability_date_value` |

`isEmpty()` is true only when `availability_status` is NULL/empty (status is the required
anchor value). `onChange()` recomputes `availability_date_object` when the date changes.

**Field settings** (`defaultFieldSettings`): `alter_add_to_cart_button` (default
`no_altering`; see [enforcement.md](enforcement.md)) and `clear_availability_date_in_stock`
(default FALSE) — when enabled, the widget nulls `availability_date_value` on save if
`availability_status == in_stock`.

Computed schema.org property: `src/TypedData/AvailabilityStatusSchemaorgComputed.php`
(extends `StringData` so the contrib Token module exposes it as a field-property token)
maps status → `https://schema.org/InStock|OutOfStock|PreOrder|BackOrder`.

## Widgets

- `commerce_product_availability_product_availability_default`
  (`src/Plugin/Field/FieldWidget/ProductAvailabilityDefaultWidget.php`) — full widget:
  orderable checkbox, status select, "Available from" datetime, min/max delivery period
  number inputs (with global-fallback placeholders). `massageFormValues()` converts the
  datetime back to storage timezone/format and applies `clear_availability_date_in_stock`.
- `commerce_product_availability_product_availability_simple`
  (`ProductAvailabilityWidgetSimple.php`) — only orderable + status.

Both widgets default `orderable` to TRUE and `availability_status` to `in_stock`, and link
to Google Merchant availability docs in the help text.

## Formatter

`commerce_product_availability_product_availability_default`
(`src/Plugin/Field/FieldFormatter/ProductAvailabilityDefaultFormatter.php`) **extends
`DateTimeDefaultFormatter`** (to reuse date formatting). Display settings (all default
TRUE): `show_availability_status`, `show_availability_date`, `hide_availability_date_in_past`,
`show_min_delivery_period`, `show_max_delivery_period`, `show_availability_indicator`.

Empty per-field min/max delivery periods fall back to the global settings
(`min/max_delivery_period_fallback`). The **availability indicator** (`getAvailabilityIndicator`)
resolves to `available` (orderable + in_stock), `limited-availability` (orderable + any
other status), or `unavailable` (not orderable) — a green/yellow/red truck glyph (`&#9951;`).

Rendering goes through `#theme` `commerce_product_availability_product_availability_default`
(registered in `commerce_product_availability_theme()`), template
`templates/commerce-product-availability-product-availability-default.html.twig`, with the
`commerce_product_availability/availability_indicator` CSS library attached. The template
is block-heavy so themes can override individual pieces.

## Global settings form

`src/Form/SettingsForm.php` at route `commerce_product_availability.settings`
(`/admin/commerce/config/products/commerce-product-availability`), permission
**`administer commerce_product_availability global settings`**. Config object
`commerce_product_availability.settings` keys: `min_delivery_period_fallback`,
`max_delivery_period_fallback`, `delivery_period_day_type` (`days` | `working_days`,
default `days`), `delivery_period_info` (free text). Config is translatable
(`.config_translation.yml`).

## Tokens

`src/Hook/CommerceProductAvailabilityTokenHooks.php` (attribute-based `#[Hook]`,
service-registered) provides token type `commerce_product_availability` with tokens
`min_delivery_period_fallback`, `max_delivery_period_fallback`, `delivery_period_day_type`,
`delivery_period_info`, and `delivery_period_fallback_formatted` (combined "min-max unit").
All values come from the global settings config.

## Install / update hooks

`.install`: `_update_10001` rebuilds the container; `_update_10002` initializes
`delivery_period_day_type` = `days` and `delivery_period_info` = ''.
