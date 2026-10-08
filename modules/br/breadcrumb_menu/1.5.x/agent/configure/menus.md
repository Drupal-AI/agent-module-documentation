<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: which menus supply breadcrumb titles

- **Route / form:** `breadcrumb_menu.settings` → `/admin/config/system/breadcrumb-menu`,
  form `Drupal\breadcrumb_menu\Form\BreadcrumbMenuSettingsForm` (form id
  `breadcrumb_menu_settings`), gated by permission `administer breadcrumb_menu`.
- **Config object:** `breadcrumb_menu.settings`.
- **Admin menu link:** `breadcrumb_menu.settings` under `system.admin_config_system`
  (weight 42).

## Config keys (schema `config/schema/breadcrumb_menu.schema.yml`)

| Key     | Type                       | Meaning                                                              |
|---------|----------------------------|---------------------------------------------------------------------|
| `menus` | `sequence` of `string`     | Menu machine names whose active trail supplies replacement titles.  |

The schema declares `orderby: key`. Fresh install ships `menus: {}` (empty) — with no menus
configured, nothing is substituted and the breadcrumb is the plain path-based trail. The
form field `menus` is `#required`, so a value must be chosen when you save through the UI.

## Form field

`menus` is an `#type => entity_autocomplete`, `#target_type => 'menu'`, `#multiple => TRUE`,
`#tags => TRUE`, `#required => TRUE`. You type comma-separated menu labels (e.g. `Main
navigation`, `Footer`); the submit handler stores the selected menu **machine names** via
`array_column($form_state->getValue('menus'), 'target_id')`.

## Set it without the UI

Drush (menu machine names, not labels):

```bash
drush config:set breadcrumb_menu.settings menus.0 main -y
drush config:set breadcrumb_menu.settings menus.1 footer -y
# inspect
drush config:get breadcrumb_menu.settings
```

PHP:

```php
\Drupal::configFactory()
  ->getEditable('breadcrumb_menu.settings')
  ->set('menus', ['main', 'footer'])
  ->save();
```

Order the trail titles by naming the menus in the order you want them consulted; the first
configured menu whose active trail contains a given URL wins the title for that link
(`$menu_link_titles[$url] ??= $menu_link->getTitle()` — first-wins per URL).

## Update hook

`breadcrumb_menu_update_10201` (in `breadcrumb_menu.install`) backfills
`menus: ['main']` on sites that predate the setting: `$config->set('menus', $config->get('menus') ?? ['main'])`.
