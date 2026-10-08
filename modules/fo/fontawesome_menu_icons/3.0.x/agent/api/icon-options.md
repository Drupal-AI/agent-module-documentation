# Storage & render surface

## The four option keys

Every icon is described by four values, stored together:

- `fa_icon` — the icon class/name (e.g. `fa-rocket`)
- `fa_icon_prefix` — style/version prefix (default `fa`)
- `fa_icon_tag` — `i` or `span` (default `i`)
- `fa_icon_appearance` — `before` | `after` | `only` (default `before`)

## Two storage locations (by link type)

1. **Custom links (`menu_link_content` entities)** — stored in the entity's `link` field
   `options` array. This is the *only* place; the config object is **not** touched.
   Confirmed on the live site: saving a `menu_link_content` with `fa_icon` options leaves
   `fontawesome_menu_icons.settings:menu_link_icons` = `null`.

2. **Module-defined links** (from `*.links.menu.yml`, edited via the generic menu-link
   edit form) — written to the `menu_tree` table `options` column **and** mirrored into
   config `fontawesome_menu_icons.settings` under
   `menu_link_icons[<link_id_with_dots_replaced_by_underscores>]` =
   `{icon, prefix, tag, appearance}`. Drupal wipes the `menu_tree.options` on cache
   rebuild, so `hook_menu_links_discovered_alter()` re-applies the icon from config on
   every rebuild. The config key replaces `.` with `_` because config keys cannot contain
   dots (e.g. `standard.admin` → `standard_admin`).

## Render pipeline (no API to call)

The module has no services or public functions — it works entirely through hooks:

- `hook_form_menu_link_content_form_alter` / `hook_form_menu_link_edit_alter` — add the
  "FontAwesome Icon" fieldset and a submit handler.
- `hook_menu_links_discovered_alter` — re-hydrate icons from config onto discovered links.
- `hook_link_alter` — wrap standard rendered links: builds
  `<i class="<prefix> <icon>" aria-hidden="true"></i>` around `text`.
- `hook_preprocess_menu` — same treatment for links rendered through a menu template
  (`_fontawesome_menu_icons_preprocess_menu_item`), walking `below` children recursively.

Appearance markup:

- `before` → `<i class="prefix icon"></i> <span class="link-text">Title</span>`
- `after`  → `<span class="link-text">Title</span> <i class="prefix icon"></i>`
- `only`   → icon replaces text; adds `aria-label` (routed link) or an `sr-only` title
  (`<nolink>`), plus `aria-hidden="true"` on the icon, for accessibility.

An `already_processed` flag on the link options prevents double-wrapping.

## Uninstall

`hook_uninstall` strips `fa_icon` out of `link__options` in `menu_link_content_data` for
every affected row (raw SQL). The config object is removed with the module.
