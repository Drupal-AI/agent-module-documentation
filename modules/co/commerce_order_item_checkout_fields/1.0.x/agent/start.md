<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Order Item Fields — agent index

Machine name `commerce_order_item_checkout_fields` (human name "Commerce Order Item Fields").
Version **1.0.0-rc1**, core `^11`. Adds a Commerce **checkout pane** that collects extra field
data **per order item, per unit of quantity** (e.g. attendee name/email for each ticket) and
stores it in real fields on the order item — never a serialized blob — so it is queryable via
Views, JSON:API and REST. No settings form of its own (`configure: null`); no permissions; no
config schema shipped. Wired up entirely through Commerce's Field UI, form-display UI and
checkout-flow UI.

- **End-to-end setup: add fields, choose a form display mode, place the pane, pane settings**
  → [configure/setup.md](configure/setup.md)
- **The `order_item_fields` pane plugin, its deriver, the excluded-type resolver, storage
  paths and lifecycle** → [internals.md](internals.md)

Key facts:
- Base pane plugin id `order_item_fields`, **derived per qualifying order item type** →
  usable id like `order_item_fields:ticket` (`src/Plugin/Derivative/OrderItemFieldsDeriver.php`).
  A derivative is generated only for order item types that have at least one qualifying field.
- **Qualifying field** = a user-added configurable field (`\Drupal\field\FieldConfigInterface`)
  whose type is not excluded. Base fields (`quantity`, `unit_price`, `purchased_entity`,
  `title`, `total_price`, `id`, `uuid`, …) are structurally filtered out (they are not
  `FieldConfigInterface`).
- **Excluded field types** (default): `file`, `image`, `entity_reference_revisions`
  (Paragraphs). Alterable via
  `hook_commerce_order_item_checkout_fields_excluded_types_alter()`
  (`commerce_order_item_checkout_fields.api.php`).
- **Editable set is a triple allow-list**: fields placed on the chosen form display mode ∩
  user-added configurable fields ∩ per-field `access('edit', $account)`. Only those are
  rendered, validated, extracted and stored.
- Pane settings (two, on top of the standard pane options): `form_display_mode` (default
  `default`) and `require_complete` (bool, default FALSE). No config schema file ships for
  these keys.
- **Two storage paths, chosen per order item from its actual quantity** (the "Combine" cart
  setting is never read):
  - Path B, quantity == 1 → value stored at delta 0 of each order item's field.
  - Path A, quantity > 1 (combined) → one value per product stored as the field's **deltas**
    on the single order item. Fields must allow enough values → unlimited cardinality
    recommended; the module *warns* (pane save, `hook_requirements`, checkout log) but never
    blocks.
- **Cardinality warnings**: `OrderItemFields::findLimitedCardinalityFields()` powers both the
  pane-config validation warning and `hook_requirements()` (status report).
- **Cart quantity decrease** trims orphaned deltas beyond the new quantity via
  `CartQuantitySubscriber` (`commerce_cart.order_item.update` event).
- **Form integrity**: on validate/submit the number of submitted delta groups must equal the
  order item's current quantity, else a form error (guards against cart-changed-in-another-tab).
- Dependencies: `drupal:field`, `commerce:commerce_checkout`, `commerce:commerce_order`,
  `commerce:commerce_cart`. Not covered by Drupal's security advisory policy.
