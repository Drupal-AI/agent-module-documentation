<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Domain Menu Access

## Settings form

Route `domain_menu_access.settings` at **`/admin/config/domain/menu/access/settings`**
(permission `administer domains`). It lists every menu as a checkbox
(`DomainMenuAccessSettingsForm`). Ticking a menu and saving stores, on that menu's
`system.menu.<id>` config entity:

```
third_party_settings.domain_menu_access.access_enabled: true
```

(unchecking removes it). Saving also clears cached block definitions so the block swap below
takes effect.

### Toggle via drush / code

```php
$menu = \Drupal\system\Entity\Menu::load('main');
$menu->setThirdPartySetting('domain_menu_access', 'access_enabled', TRUE)->save();
// off:
$menu->unsetThirdPartySetting('domain_menu_access', 'access_enabled')->save();
```

Read it: `$menu->getThirdPartySetting('domain_menu_access', 'access_enabled')`.

## The domain_access field on menu links

This module's `config/install` ships:
- `field.storage.menu_link_content.domain_access` — entity_reference → `domain`,
  cardinality `-1`, `persist_with_no_fields: true`.
- `field.field.menu_link_content.menu_link_content.domain_access` — label "Domain Access",
  `behavior: auto`, `default_value_callback: domain_entity_field_default_domains`.

So `menu_link_content` is always domain-enabled while this module is installed
(`hook_uninstall` deletes the field storage again). An empty value = the link is available on
**all** domains.

## What happens on an enabled menu

- `hook_form_menu_link_content_form_alter()` moves the `domain_access` field into a **Domain**
  details group and only makes it visible when the link's menu has `access_enabled` set.
- `hook_block_alter()` replaces the `system_menu_block:<menu>` plugin with
  `domain_access_menu_block` (`DomainMenuAccessMenuBlock`) for enabled menus.
- `DomainMenuLinkTreeManipulators::checkDomain()` runs after core access checks: for each
  link it loads the `menu_link_content` entity and, unless the domain field is empty, forbids
  the link when the active domain (`domain.negotiator` → `getActiveDomain()->getOriginalId()`)
  is not among its `domain_access` target ids. Forbidden links become `InaccessibleMenuLink`
  with their subtree removed. Results add the `url.site` cache context.

## Field-form permissions

`hook_entity_field_access()` hides/permits the domain fields on the menu-link form based on the
Domain Access permissions `publish to any domain` and `publish to any assigned domain`.
