<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable domain control per menu

Domain filtering is opt-in per menu. Only menus listed in
`domain_menu_access.settings:menu_enabled` get per-link domain fields and per-domain
filtering; all other menus behave exactly like stock Drupal.

## Settings form

- Route: `domain_menu_access.settings` → `/admin/config/domain/domain_menu_access/config`
- Permission: `administer domains`
- Form class: `Drupal\domain_menu_access\Form\DomainMenuAccessSettingsForm` (form id
  `domain_menu_access_settings`, extends `ConfigFormBase`)
- The form loads every `menu` entity and renders a checkbox per menu (title = menu label).
  Checked menus are saved into `menu_enabled` (an array of menu machine names). If no menus
  exist it shows *"Your menu list is empty…"*.

## Config object

Single config object `domain_menu_access.settings`, one key:

| Key | Type | Meaning |
|---|---|---|
| `menu_enabled` | sequence of string | Machine names of menus that participate in domain filtering. Default `[]`. |

Schema: `config/schema/domain_menu_access.schema.yml` → `domain_menu_access.settings`
(`config_object`, `menu_enabled` = sequence of string). Install default:
`config/install/domain_menu_access.settings.yml` = `menu_enabled: []`.

## Set without the UI

```bash
# Inspect
drush cget domain_menu_access.settings menu_enabled

# Enable domain control for the "main" and "footer" menus
drush cset domain_menu_access.settings menu_enabled.0 main -y
drush cset domain_menu_access.settings menu_enabled.1 footer -y
```

```php
\Drupal::configFactory()
  ->getEditable('domain_menu_access.settings')
  ->set('menu_enabled', ['main', 'footer'])
  ->save();
```

## Effect of enabling a menu

1. Menu-link edit forms for links in that menu expose the two Domain Access fields (see
   [../configure/menu-link-domains.md](../configure/menu-link-domains.md)).
2. The block deriver publishes a "Domain Menu" block for that menu (see
   [../blocks/domain-menu-block.md](../blocks/domain-menu-block.md)); rendering the menu
   through that block is what applies the per-domain filtering.
