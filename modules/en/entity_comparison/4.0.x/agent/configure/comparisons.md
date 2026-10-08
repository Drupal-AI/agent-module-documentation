<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Creating and configuring a comparison

## Install

```bash
composer require drupal/entity_comparison
drush en entity_comparison -y
```

## Create one

UI: *Structure → Entity comparison → Add* (`/admin/structure/entity_comparison/add`).

Fields: **Label**, machine name, **Add to comparison list** link text, **Remove from
comparison** link text, **Limit** (`0` = no limit), **Entity type**, **Bundle**.

From the CLI:

```bash
drush php:eval '\Drupal\entity_comparison\Entity\EntityComparison::create([
  "id" => "products",
  "label" => "Products",
  "add_link_text" => "Add to compare",
  "remove_link_text" => "Remove from compare",
  "limit" => 4,
  "entity_type" => "node",
  "bundle_type" => "product",
])->save();'

drush cget entity_comparison.entity_comparison.products
```

Config object shape (`entity_comparison.entity_comparison.{id}`):

```yaml
id: products
label: Products
add_link_text: 'Add to compare'
remove_link_text: 'Remove from compare'
limit: 4
entity_type: node
bundle_type: product
```

## What creating one generates

`EntityComparison::postSave()` (only on insert):

1. **View mode** `{entity_type}.{bundle}_{id}` — e.g. `node.product_products`, labelled with the
   comparison's label.
2. `router.builder`'s `rebuildIfNeeded()` — the `/compare/products` route only exists after this.
3. `drupal_flush_all_caches()`.

`calculateDependencies()` then ties the config entity to that view mode and the corresponding
`core.entity_view_display` — so exporting a comparison drags the display config along.

Deleting a comparison does **not** delete the generated view mode; clean it up yourself if you
care:

```bash
drush cdel core.entity_view_mode.node.product_products -y
```

## Choosing which fields get compared

The comparison table renders fields from the **entity view display** for the generated view mode:

```bash
# Enable and configure it:
drush cset core.entity_view_display.node.product.product_products status true -y
drush cget core.entity_view_display.node.product.product_products content --format=yaml
```

In the UI: *Structure → Content types → Product → Manage display → Products* (the custom display
named after your comparison). Field order there is row order in the table; formatter settings
apply as usual. Only fields enabled in that display appear.

Note the display id is `{bundle}_{id}` while the view mode id is `{entity_type}.{bundle}_{id}` —
the controller loads `EntityViewDisplay::load("{entity_type}.{bundle}.{bundle}_{id}")`.

## Placing the add/remove link

Three ways, all driven by the same render element (`#theme: entity_comparison_link`):

1. **Entity display component** — `hook_entity_extra_field_info()` registers
   `link_for_entity_comparison_{id}` on the target bundle, so enable it in any view mode
   (Default, Teaser, …) via *Manage display*.
2. **Views field** — `hook_views_data_alter()` adds a comparison-link field for the entity's data
   table; add it to any view of that bundle.
3. **Block** — the `entity_comparison_link_block` derivative (one per comparison).

There is also a computed base field `entity_comparison_link` (`setCustomStorage(TRUE)`) with the
formatter `entity_comparison_link`, whose setting key is `enitity_comparison` (sic — the typo is
in the schema and the code, keep it when writing config by hand).

## The comparison page

Path: `/compare/` + the comparison id with `_` replaced by `-` (`products` → `/compare/products`,
`my_products` → `/compare/my-products`). Requires the generated permission
`use {id} entity comparison`.

```bash
drush role:perm:add anonymous 'use products entity comparison'
drush cr    # after adding a comparison, so its route exists
```

## Limit behaviour

`limit = 0` means unlimited. Otherwise the controller allows an add when the resulting count is
`<= limit`; over the limit it shows *"You can only add @limit items to the %comparison list."*
as an error. The check is per comparison, per session.
