<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Layout Builder Direct Add

## Config object: `lb_direct_add.settings`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `use_label` | integer | `0` | `0` = render as a core **dropbutton**; `1` = render as a **popover menu** (a labelled trigger link that reveals the block list). |
| `label` | string | `Add block` | Text of the popover trigger link. Only used when `use_label = 1`. |

Shipped defaults (`config/install/lb_direct_add.settings.yml`): `use_label: 0`, `label: 'Add block'`.

## Settings form

- Form class: `Drupal\lb_direct_add\Form\SettingsForm` (`ConfigFormBase`), form id
  `lb_direct_add_settings`.
- Route: **`lb_direct_add.settings_form`** at
  `/admin/config/content/layout-builder-direct-add` (menu link "Layout Builder Direct Add"
  under *Configuration → Content authoring*).
- Fields: *How to display list* (radios → `use_label`: "Dropbutton" / "Popover menu") and
  *Label name* (`label`, visible only when Popover menu is selected).
- Permission required to reach the form: `administer layout builder direct add settings`.

> Note: the `.info.yml` declares `configure: lb_direct_add.settings`, but the real route name is
> `lb_direct_add.settings_form`. Use the latter with `\Drupal\Core\Url::fromRoute()` / `drush`.

## Set via drush

```bash
# Switch to the popover menu with a custom trigger label:
drush cset lb_direct_add.settings use_label 1 -y
drush cset lb_direct_add.settings label 'Add content' -y

# Back to the default dropbutton:
drush cset lb_direct_add.settings use_label 0 -y
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('lb_direct_add.settings')
  ->set('use_label', 1)->set('label', 'Add content')->save();
```

## Read it back

```bash
drush cget lb_direct_add.settings
```

There is no per-entity or per-view-mode toggle — once the module is enabled the widget applies
to every Layout Builder region. The only configuration is this global dropbutton-vs-popover
choice.
