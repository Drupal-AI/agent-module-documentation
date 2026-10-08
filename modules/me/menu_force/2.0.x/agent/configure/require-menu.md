<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Require menu placement on a content type

Menu Force has **no configure route** and no settings form. You turn it on per content type
on the node-type edit form, or directly in the `node.type.<bundle>` config entity.

## Where the setting is stored

Config entity: `node.type.<bundle>` (e.g. `node.type.article`). Path within it:

```yaml
third_party_settings:
  menu_force:
    menu_force: true          # make Menu settings mandatory for this type
    menu_force_parent: true    # (optional) also lock the "Default parent item"
```

Both are booleans validated by the schema
`node.type.*.third_party.menu_force` (keys `menu_force`, `menu_force_parent`).

## Via the UI

1. Go to *Structure → Content types → <your type> → Edit*
   (`/admin/structure/types/manage/<bundle>`).
2. Open the **Menu settings** vertical tab.
3. Tick **Make the Menu Settings mandatory for this content type**.
4. Optionally tick **Lock the "Default parent item" as well** (only visible once the first
   box is checked). If you lock the parent you must also pick a real *Default parent item*
   in the same tab, or the form fails validation
   ("If you want to force a Default parent menu item, please select which one.").
5. **Save content type**.

## Via drush php:eval (scriptable)

```php
$type = \Drupal\node\Entity\NodeType::load('article');
$type->setThirdPartySetting('menu_force', 'menu_force', TRUE);
$type->setThirdPartySetting('menu_force', 'menu_force_parent', FALSE);
$type->save();
```

To turn it back off, set `menu_force` to `FALSE` (and `menu_force_parent` to `FALSE`) and
save, or `$type->unsetThirdPartySetting('menu_force', 'menu_force')`.

## Read it back

```bash
drush cget node.type.article third_party_settings.menu_force
# menu_force: true
# menu_force_parent: false
```

Requires the core **`menu_ui`** module (a hard dependency). Menu Force sets its own module
weight to 1 on install so its form alters run after `menu_ui`.
