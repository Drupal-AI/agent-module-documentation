<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Assign domains to a menu link

The module reuses Domain Access's own two fields on the `menu_link_content` entity, so a menu
link is scoped to domains the same way a node is.

## Fields

Both are created on `hook_install` via `domain_access_confirm_fields('menu_link_content',
'menu_link_content', …)`, mirroring the field storage shipped in `config/install/`:

| Field | Constant | Type | Cardinality | Meaning |
|---|---|---|---|---|
| `field_domain_access` | `DomainAccessManagerInterface::DOMAIN_ACCESS_FIELD` | entity_reference → `domain` | -1 (multiple) | Domains the link belongs to. |
| `field_domain_all_affiliates` | `DomainAccessManagerInterface::DOMAIN_ACCESS_ALL_FIELD` | boolean | 1 | "Send to all affiliates" — link shows on every domain. |

`hook_install` first creates the `menu_link_content.menu_link_content.default` form display if it
does not exist (menu links have no form display by default), so the fields have somewhere to
render. `hook_uninstall` deletes that form display and both field storages.

## Editing on the menu-link form

`domain_menu_access_form_menu_link_content_form_alter()` (in `.module`):

- If the link's menu **is** in `domain_menu_access.settings:menu_enabled`: the two fields are
  grouped into a `details` element `#title` **"Domain"** (`#weight` 25, open), and
  `domain.element_manager->setFormOptions($form, $form_state, DOMAIN_ACCESS_FIELD)` adds the
  hidden domain options the current user cannot see (same helper Domain Access uses on nodes).
- If the menu is **not** enabled: both fields get `'#access' => FALSE`, so they are hidden. A
  link in a non-participating menu therefore keeps whatever domain values it already had, unseen.

`domain_menu_access_menu_link_content_presave()` calls `domain_access_presave_generate($entity)`
so Devel Generate-created test links get domain values assigned automatically (no effect without
Devel Generate).

## Assignment semantics (how a link is scoped)

Evaluated by `DomainMenuLinkTreeManipulators::menuLinkCheckAccess()` /
`isAvailableOnAllAffiliates()`:

- `field_domain_all_affiliates` set and its value is **not** `'0'` → link is on **all** domains.
- Otherwise the link is limited to the domains referenced by `field_domain_access`.
- A link with **no** `field_domain_access` values and no "all affiliates" flag is limited to the
  empty set — i.e. it is filtered out on every domain when the menu is rendered through the
  module's block (see [../blocks/domain-menu-block.md](../blocks/domain-menu-block.md)).

## Set via PHP

```php
$link = \Drupal::entityTypeManager()->getStorage('menu_link_content')->load($id);
$link->set('field_domain_access', ['domain_a', 'domain_b']); // domain entity ids
$link->set('field_domain_all_affiliates', 0);
$link->save();
```

## Menu overview column

`domain_menu_access_preprocess_table__menu_overview()` inserts a **Domains** column (position 1,
right after the menu-link name) into the `admin/structure/menu/manage/*` overview, listing each
link's assigned domain names (resolved by loading the `menu_link_content` entity by the UUID
parsed from the row's `data-drupal-selector`). Rows whose link is not assigned to the active
domain get the `visually-hidden` CSS class unless the viewer has
`administer menu items across domains` (see [../permissions/permissions.md](../permissions/permissions.md)).
