<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & bulk operations — `domain_menus.settings`

Form: `Drupal\domain_menus\Form\DomainMenusSettingsForm` (route `domain_menus.settings`,
path `/admin/config/domain/domain_menus`, permission `administer domains`).
Config object: **`domain_menus.settings`**.

## Config keys (shipped defaults)

```yaml
domain_menus_menu_names: "main\r\nalt"       # newline-separated menu "names"
domain_menus_filter_node_autocomplete: 1     # filter node-link autocomplete by domain
domain_menus_hide_from_menu_list: 0          # hide auto-created menus from admin/structure/menu
domain_menus_hide_admin_toolbar_links: 0     # hide them from the Admin Toolbar dropdown
domain_menus_content_types_available_menus: []  # bundles where domain menus are an available parent
domain_menus_default_parent_menu_name: ''    # a menu name to use as default parent on node forms
```

`domain_menus_create` and `domain_menus_delete` are **operation checkboxes** on the form, not
persisted settings — ticking one performs the bulk action on submit.

## Menu names, not menu ids

`domain_menus_menu_names` is a list of short "names" (e.g. `main`, `alt`). The actual per-domain
menu id is generated as `dm<domainId>-<name>` (e.g. `dm1-main`) via
`DomainMenusConstants::DOMAIN_MENUS_MENU_ID_PATTERN` (`'dm%u-%s'`). Validation: each name must be
alphanumeric and < 10 characters. `domain_menus_default_parent_menu_name` must be one of the names
(or empty).

## Bulk create / delete

- Tick **Operation: Create menus** and Save → one `Menu` entity per name per domain is created,
  each with third-party settings `domain_menus.domains = [<domain_id> => <domain_id>]` and
  `domain_menus.auto-created = 1`.
- Tick **Operation: Delete menus** and Save → auto-created domain menus for the names are removed.

The same create/delete happens automatically on `hook_domain_insert` / `hook_domain_delete` (a new
domain gets menus for every configured name; a deleted domain's auto-created menus are removed, or
just un-assigned if the menu also belongs to other domains).

## Read / write with drush

```bash
drush cget domain_menus.settings
drush cset domain_menus.settings domain_menus_menu_names $'main\r\nfooter' -y
drush cset domain_menus.settings domain_menus_hide_from_menu_list 1 -y
```

## Marking an existing menu as a domain menu

Any menu becomes a domain menu when it has a non-empty `domain_menus.domains` third-party setting
(`_domain_menus_is_domain_menu()`), which users with `administer menu` can set on the menu add/edit
form's **Domain(s)** checkboxes:

```php
$menu = \Drupal\system\Entity\Menu::load('my_menu');
$menu->setThirdPartySetting('domain_menus', 'domains', ['default' => 'default']);
$menu->save();
```
