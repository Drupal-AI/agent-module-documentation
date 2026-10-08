<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Require menu placement on a vocabulary

No configure route and no settings form. You turn it on per vocabulary on the vocabulary edit
form, or directly in the `taxonomy.vocabulary.<vid>` config entity.

## Where the setting is stored

Config entity: `taxonomy.vocabulary.<vid>` (e.g. `taxonomy.vocabulary.tags`):

```yaml
third_party_settings:
  menu_force_taxonomy_menu_ui:
    menu_force_taxonomy_menu_ui: true          # make Menu settings mandatory for terms
    menu_force_taxonomy_menu_ui_parent: true    # (optional) also lock the Default parent item
```

Both are booleans. Note the module's schema file declares the key
`taxonomy.vocabulary.*.third_party.menu_force`, which does **not** match the
`menu_force_taxonomy_menu_ui` provider the code writes under — the value still lives under the
`menu_force_taxonomy_menu_ui` provider.

## Via the UI

1. Ensure the contrib **`taxonomy_menu_ui`** module is enabled (hard dependency).
2. Go to *Structure → Taxonomy → <vocabulary> → Edit*
   (`/admin/structure/taxonomy/manage/<vid>`).
3. Tick **Make the Menu Settings mandatory for this content type**.
4. Optionally tick **Lock the "Default parent item" as well** (choose a real default parent,
   or validation fails).
5. **Save**.

## Via drush php:eval (scriptable)

```php
$vocab = \Drupal\taxonomy\Entity\Vocabulary::load('tags');
$vocab->setThirdPartySetting('menu_force_taxonomy_menu_ui', 'menu_force_taxonomy_menu_ui', TRUE);
$vocab->setThirdPartySetting('menu_force_taxonomy_menu_ui', 'menu_force_taxonomy_menu_ui_parent', FALSE);
$vocab->save();
```

## Read it back

```bash
drush cget taxonomy.vocabulary.tags third_party_settings.menu_force_taxonomy_menu_ui
# menu_force_taxonomy_menu_ui: true
# menu_force_taxonomy_menu_ui_parent: false
```

The menu widget on the term form comes from the contrib `taxonomy_menu_ui` module; this
submodule only makes that widget's menu link required.
