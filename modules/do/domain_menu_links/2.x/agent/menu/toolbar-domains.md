<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Toolbar "Domains" dropdown — mechanism

How the admin-toolbar domain switcher is built. All classes are under
`src/`; the menu-link declaration is `domain_menu_links.links.menu.yml`.

## Enable

`ddev drush en domain_menu_links -y`. Requires the `domain` and `admin_toolbar` modules (declared
in `domain_menu_links.info.yml` and `composer.json`: `drupal/domain ^2.0 || ^3.0`,
`drupal/admin_toolbar ^3.3`). No config import needed beyond the shipped
`config/install/domain_menu_links.settings.yml`.

## The declared menu link

`domain_menu_links.links.menu.yml` declares **`domain_menu_links.domain`**:

- `title: 'Domains'`, `route_name: <front>`, `parent: system.admin`, `menu_name: admin`.
- `class: Drupal\domain_menu_links\Plugin\Menu\DomainMenu`.
- `deriver: Drupal\domain_menu_links\Plugin\Derivative\DomainMenuDeriver`.
- `options.attributes.class: [toolbar-icon-domain-menu]` (styled by
  `assets/css/domain-menu-links.css`, library `domain_menu_links/domain_menu_links`).

Because it lives under `system.admin` in the `admin` menu, **Admin Toolbar** renders it as a
top-level toolbar item with a hover dropdown of its children.

## Derivative — one link per enabled domain

`DomainMenuDeriver` (`src/Plugin/Derivative/DomainMenuDeriver.php`) implements
`ContainerDeriverInterface` and injects `entity_type.manager`.
`getDerivativeDefinitions($base)`:

1. Loads **all** `domain` entities (`getStorage('domain')->loadMultiple()`); returns `[]` (no links)
   if there are none.
2. Sets `$derivatives[0] = $base_plugin_definition` — the parent. (Derivative id `0` is falsy, so
   core's `DerivativeDiscoveryDecorator` keeps it under the bare id `domain_menu_links.domain`, which
   is what the child links name as their `parent`.)
3. For each domain: **skips disabled domains** (`if (!$domain->status()) continue;`) and adds a
   derivative keyed by the domain id with:
   - `title` = `$domain->label()`, `url` = `$domain->getPath()`, `weight` = `$domain->getWeight()`.
   - `parent` = `domain_menu_links.domain`, `provider` = `domain_menu_links`.
   - `class` = `DomainMenuLink::class`.
   - `options.attributes.target = '_blank'` and class `domain-menu-links-link`
     (`DomainMenuLinksConstants::DOMAIN_MENU_LINK_CLASS`).
   - `cache` = the domain's own `tags` / `context` / `max-age`.

So each child opens the target domain in a **new tab**; the set of children equals the enabled
domains.

## Menu-link plugin classes

`Plugin/Menu/DomainMenu` (parent, `src/Plugin/Menu/DomainMenu.php`) extends `MenuLinkDefault` and
injects `menu_link.static.overrides`, `config.factory`, `entity_type.manager`, `current_user`:

- `getWeight()` returns config `domain_menu_links.settings:parent_menu_link_weight` — this is the
  knob the settings form controls.
- `getCacheContexts()` → **`['url.site']`**; `getCacheTags()` → **`['domain_list']`**.
- `isEnabled()` → `current_user->hasPermission('view toolbar domain menu') && !empty($domains)` — the
  whole dropdown is hidden unless the viewer has the permission and domains exist.

`Plugin/Menu/DomainMenuLink` (children, `src/Plugin/Menu/DomainMenuLink.php`) extends
`MenuLinkDefault`, injects `entity_type.manager`, and in its constructor parses the domain id from
the plugin id (`explode(':', $pluginDefinition['id'])[1]`) to load `$this->domain`.
`getCacheContexts()`/`getCacheTags()` return that domain's contexts/tags (or `[]` if not loaded).

## Keeping the menu in sync (`domain_menu_links.module`)

- `hook_domain_insert`, `hook_domain_update`, `hook_domain_delete` each call
  `\Drupal::service('plugin.manager.menu.link')->rebuild()`, so adding/renaming/removing a domain
  regenerates the derivatives immediately.
- `hook_page_attachments()` attaches library `domain_menu_links/domain_menu_links` only when the user
  is **authenticated** and holds both `access toolbar` and `view toolbar domain menu`.
- `hook_help()` provides the About text on `help.page.domain_menu_links`.

## Permission

`domain_menu_links.permissions.yml` defines a single permission:

- **`view toolbar domain menu`** — "View the toolbar domains menu and its links." Grant it to the
  roles that should be able to see and use the switcher (constant
  `DomainMenuLinksConstants::DOMAIN_MENU_PERMISSION`).

## Notes

- This is admin navigation only: it does **not** add a field to menu links, does **not** alter the
  menu-link edit form, and does **not** filter or hide site menu links per domain. It simply lists
  the domains.
- The parent link's `url.site` cache context + `domain_list` cache tag mean the rendered dropdown is
  keyed per site URL and invalidated whenever the domain list changes; child links carry each
  domain's own cache metadata.
