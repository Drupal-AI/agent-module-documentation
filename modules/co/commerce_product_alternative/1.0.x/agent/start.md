<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Product Alternative (commerce_product_alternative) — agent index

Lets a shopper **swap a variation already in their cart** for an admin-designated
**alternative variation**, in place, via an AJAX modal — the order item is
replaced (quantity, resolved price, and custom fields carried over) instead of
being removed and re-added. Store managers assign the valid alternatives per
variation. Installed **1.0.0** (version dir `1.0.x`). Package `Commerce (contrib)`.
Core `^11`. License GPL-2.0-or-later. No config settings form, **no permissions
file** (access is ownership/validity-based, not role-based).

This is a **cart-line switcher**, not a product-page variation picker: links are
rendered against a cart **order item** and the target must be a published,
available alternative of the item's current variation.

## Dependencies

From `.info.yml`: `commerce`, `commerce_product`, `commerce_order`,
`commerce_cart`, `commerce_log`. `composer.json` requires
`drupal/commerce:^2 | ^3`. No third-party PHP libraries. Front-end uses core
`core/drupal.dialog.ajax` only.

## What it provides (all from source)

- **Commerce EntityTrait** `purchasable_entity_alternative`
  (`src/Plugin/Commerce/EntityTrait/PurchasableEntityAlternative.php`) — assignable
  to `commerce_product_variation` types. When enabled on a variation type it
  installs the `variation_alternative` bundle field (unlimited cardinality,
  references `commerce_product_variation`). Form display defaults to the CTA
  widget, view display to the AJAX-links formatter.
- **Field type** `variation_alternative`
  (`src/Plugin/Field/FieldType/VariationAlternativeItem.php`) — extends core
  `EntityReferenceItem`, adds a nullable `cta` varchar(255) column (per-item link
  label override). Storage target-type options are restricted to entity types
  implementing `PurchasableEntityInterface`; default target type
  `commerce_product_variation`. Its list class
  (`VariationAlternativeFieldItemList`) attaches the `NoCircularAlternative`
  constraint.
- **Widgets** — `variation_alternative` (plain entity-reference autocomplete, no
  CTA) and `variation_alternative_cta` (autocomplete + a "Link label override
  (CTA)" text field per item). Both extend
  `EntityReferenceAutocompleteWidget`.
- **Formatter** `commerce_product_variation_alternative`
  (`VariationAlternativesFormatter`) — renders each alternative as an AJAX modal
  switch link, **but only when an order item is present** at
  `$items->getEntity()->_context['order_item']`; otherwise returns `[]`. Has a
  `prefix` setting prepended to the label when no per-item CTA is set.
- **Views field** `commerce_product_alternative_variation_links`
  (`Plugin/views/field/VariationAlternativeLinks.php`, exposed on
  `commerce_order_item` via `hook_views_data_alter` in `Hook/DefaultHooks.php`) —
  the **recommended cart-view integration**. Renders an `item_list` of AJAX swap
  links for the order item's purchased variation's alternatives, with
  configurable list/item/link CSS classes (`use-ajax` always added).
- **Switch route + confirm form** — `commerce_product_alternative.switch` at
  `/cart/variation-alternative/{commerce_order_item}/{commerce_product_variation}`
  (`.routing.yml`) → `SwitchConfirmForm`, an AJAX modal showing current vs.
  target label and resolved price; Confirm delegates to `SwitchManager`.
- **Switch manager** `SwitchManager::switchItem()` — removes the source order
  item, creates a replacement from the target purchasable entity, preserves
  quantity, resolves the price via the chain price resolver, copies custom
  (non-base) fields shared by both bundles, adds it to the cart, and writes a
  `commerce_log` entry.
- **Access checker** `SwitchAccessChecker` (`_commerce_product_alternative_switch_access`)
  — gates the route: draft cart, cart belongs to the current user, target is
  listed as an alternative of the source, target published, target passes the
  Commerce availability pipeline.
- **Constraint** `NoCircularAlternative` — a variation may not list itself as an
  alternative.
- **Commerce log template** `commerce_product_alternative_item_switched`
  (`.commerce_log_templates.yml`) — "Cart item switched" log on the order.
- **Config schema** for the field settings/formatter/widgets
  (`config/schema/commerce_product_alternative.schema.yml`).

## Access model (no permissions)

There is **no `.permissions.yml`**. The switch route is protected entirely by
`SwitchAccessChecker`, which verifies the acting user owns the draft cart and
that the requested target is a published, available, listed alternative of the
current variation. The switch itself runs through a Drupal form (CSRF token).
Rendered links respect this: both the formatter and the views field skip any
alternative whose switch URL fails `$url->access()`, so unpublished or
unavailable variations are not exposed.

## Detail docs

- **Switch route, access checker, confirm form, and SwitchManager mechanics** →
  [switch-flow.md](switch-flow.md)

## Tests (kernel, `tests/src/Kernel/`)

- `EntityTraitTest` — trait discoverable; assigning it installs the field,
  removing it uninstalls the field.
- `SwitchManagerTest` — shared custom field copied to the new item; switching to
  a bundle lacking the field does not error.
- `NoCircularAlternativeConstraintTest` — self-reference invalid, cross-reference
  valid.
