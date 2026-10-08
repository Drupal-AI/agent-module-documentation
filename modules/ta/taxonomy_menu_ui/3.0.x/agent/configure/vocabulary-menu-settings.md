<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-vocabulary menu settings

There is no admin page for this module (`configure: null`). Everything is configured on the
**vocabulary edit form**, in a "Menu settings" group added to `additional_settings`.

## Where it is stored — mind the provider name

`taxonomy_menu_ui_form_taxonomy_vocabulary_form_builder()` writes to the vocabulary's
third-party settings using the **`menu_ui`** provider (core's name, reused on purpose), not
`taxonomy_menu_ui`:

```yaml
# taxonomy.vocabulary.<vid>
third_party_settings:
  menu_ui:
    available_menus:      # sequence of menu machine names
      - main
      - footer
    parent: 'main:'       # "<menu_name>:<parent menu link plugin id>"
```

Schema: `config/schema/taxonomy_menu_ui.schema.yml` declares
`taxonomy.vocabulary.*.third_party.menu_ui` with `available_menus` (sequence of string) and
`parent` (string).

Defaults when the keys are absent — read in code as
`$vocabulary->getThirdPartySetting('menu_ui', 'available_menus', ['main'])` and
`getThirdPartySetting('menu_ui', 'parent', 'main:')`:

| Key | Default | Meaning |
|---|---|---|
| `available_menus` | `['main']` | menus a term of this vocabulary may be placed in |
| `parent` | `'main:'` | default parent for a new link; empty part after `:` = menu root |

The `parent` string is split on the **first** `:` — `main:` means "main menu, root";
`main:menu_link_content:<uuid>` means "under that link".

## Via the UI

1. Go to *Structure → Taxonomy → <vocabulary> → Edit* (`/admin/structure/taxonomy/manage/<vid>`).
2. Open **Menu settings** in the vertical tabs.
3. Tick the menus under **Available menus**.
4. Choose a **Default parent item**.
5. Save.

Validation (`taxonomy_menu_ui_form_taxonomy_vocabulary_form_validate()`): if at least one menu
is ticked, the chosen parent must belong to one of them, else the form errors with *"The
selected menu item is not under one of the selected menus."* If **no** menu is ticked,
`menu_parent` is silently forced to `''`.

## Via drush php:eval (scriptable)

```php
$v = \Drupal::entityTypeManager()->getStorage('taxonomy_vocabulary')->load('tags');
$v->setThirdPartySetting('menu_ui', 'available_menus', ['main', 'footer']);
$v->setThirdPartySetting('menu_ui', 'parent', 'main:');
$v->save();
```

Read it back:

```bash
drush config:get taxonomy.vocabulary.tags third_party_settings.menu_ui
```

To turn the feature off for a vocabulary set `available_menus` to `[]` — the term form alter
returns early and no Menu settings group is rendered.

## Form display placement

`taxonomy_menu_ui_entity_extra_field_info()` registers a **form** extra field `menu`
("Menu settings", weight 10) for every vocabulary bundle of `taxonomy_term`, so the group can
be reordered or hidden on *Manage form display*
(`core.entity_form_display.taxonomy_term.<vid>.default` → `content.menu` / `hidden.menu`).
`hook_uninstall()` clears `content.menu` from every such display when the module is removed.
