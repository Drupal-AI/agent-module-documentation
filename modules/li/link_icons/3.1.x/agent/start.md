<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link Icons formatter (link_icons) — agent index

Field formatter for core **Link** fields that renders a **Font Awesome** icon for the service a link
points to (Facebook glyph for `facebook.com`, envelope for `mailto:`, phone for `tel:`, navy globe as
the generic fallback), optionally alongside the link title/URL. The mapping from domain → icon is data,
not code: each service is a **`link_icon_service` config entity** (hostnames + FA icon id/style/colour/
class) with a full admin CRUD UI. At render time the formatter `parse_url()`s the link, takes the last
2–5 hostname labels, and matches them against every service's `hostnames`; the matched service's icon
id, style and colour are assembled into Font Awesome `<i class="fa …">` markup by the shared helper
`_link_icons_link_markup()`. The set of recognised services is extendable/overridable without code, and
the companion submodule **`link_icons_brands`** ships ~100 ready-made brand services (Facebook, X,
LinkedIn, GitHub, …) as `config/optional` entities.

Three entry points share the same rendering helper: (1) the **`link_icons_formatter`** field formatter
plugin (`viewElements()` in `LinkIconsFormatter.php`) — the primary surface, set on any Link field's
display; (2) **menu integration** — `hook_form_menu_form_alter` adds a per-menu "Render external links
with icons?" toggle whose settings persist to `link_icons.menu.<menu_id>` config, and
`hook_preprocess_menu` rewrites each external menu item's title through the helper; (3) the
**`link_icon_service` admin UI** at `/admin/config/search/link_icon_service` for managing the service
entities. There are no controllers, no services.yml, no REST/webhook routes, and no Drush.

- Depends on: `drupal:link` (core Link field), `fontawesome:fontawesome` (`^2 || ^3`, contrib — supplies the icon library).
- Core: `^8 || ^9 || ^10 || ^11`. Package: `Fields`. Version `3.1.0-rc7`.
- Configure route (info.yml `configure`): `entity.link_icon_service.collection` (`/admin/config/search/link_icon_service`).
- Permissions: one — `administer link icon services` (gates all service CRUD).
- Plugin types defined: none. It DEFINES one config entity type (`link_icon_service`) and one field-formatter plugin.
- Drush: none. Config schema: yes (config entity + `field.formatter.settings.[link_icons_formatter]`).
- Submodule: `link_icons_brands` (config-only; ~100 `link_icon_service` entities in `config/optional`, plus `hook_update_N` importers). Depends on `link_icons:link_icons (>=3.1)`.
- Requires the Font Awesome library to actually load on the page; otherwise the emitted `<i class="fa …">` markup renders as nothing.

## What you'd do → where
- Set/tune the formatter on a Link field, understand its 8 settings → [fields/formatters.md](fields/formatters.md)
- Add/override a recognised service (hostnames → icon), the config entity + admin UI + schema → [configure/services.md](configure/services.md)
- Turn on link icons for a menu's external items (per-menu config) → [configure/menus.md](configure/menus.md)

## Key facts (real machine names)
- Field formatter plugin: `link_icons_formatter` (class `Plugin\Field\FieldFormatter\LinkIconsFormatter`, label "Link with service icon", field type `link`). NOTE: the legacy `link_icons_field_formatter_info()` hook in `.module` (id `link_icons_icon`, field type `link_field`) is a Drupal 7-style hook that Drupal 8+ never invokes — dead code; the plugin above is the only registered formatter.
- Config entity type: `link_icon_service` (class `Entity\LinkIconService`), config prefix `link_icons.link_icon_service.*`, `admin_permission: "administer link icon services"`, route provider `AdminHtmlRouteProvider`. Exported keys: `id, label, hostnames[], class, icon, icon_style, icon_square, icon_circle, color`.
- Routes (all under `/admin/config/search/link_icon_service`): `entity.link_icon_service.collection` (`_permission: administer link icon services`), `.add_form` (`_entity_create_access`), `.edit_form` (`_entity_access: …update`), `.delete_form` (`_entity_access: …delete`).
- Permission: `administer link icon services` (`link_icons.permissions.yml`).
- Formatter settings keys (defaults): `text=title`, `hideURLscheme=TRUE`, `order=first`, `size=1x`, `width=fixed`, `coloured=coloured`, `shaped=natural`, `background=none`. Schema `field.formatter.settings.[link_icons_formatter]`.
- Menu config objects: `link_icons.menu.<menu_id>` (hyphens → underscores) with key `render` (bool) plus the same 8 settings keys.
- Shared render helper: `_link_icons_link_markup(string $title, string $url, array $settings, array $services = [], bool $link = FALSE)` in `link_icons.module`. Form-field builder: `_link_icons_config_fields(array $settings)`.
- Hooks implemented: `hook_help`, `hook_requirements`, `hook_install`, `hook_update_8001`, `hook_preprocess_menu`, `hook_form_menu_form_alter` (+ submit `_link_icons_menu_edit_submit`). Special schemes hardcoded in the helper: `mailto:` → envelope, `tel:` → phone; unmatched http(s) host → generic navy `globe`.
- Menu links: action `entity.link_icon_service.add_form`; menu link `entity.link_icon_service.collection` under `system.admin_config_search`.
