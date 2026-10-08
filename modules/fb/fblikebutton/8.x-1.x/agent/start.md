<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facebook Like Button (fblikebutton) — agent index

Adds Facebook's official **Like** social plugin to a Drupal site two ways: an auto-attached per-node button on
selected content types, and a configurable **Like box block**. Package `Social`. License GPL-2.0-or-later.
Version 8.x-1.0. Core `^8.8 || ^9 || ^10 || ^11`. No module or PHP-library dependencies.

## Dependencies

None declared in `fblikebutton.info.yml`. Functionally uses core **node** (reads `node_type_get_names()`,
attaches to node view) and **block** (for the block plugin). No composer `require` entries, no external
libraries — Facebook's SDK is loaded from `connect.facebook.net` at runtime by the template.

## What it provides (from source)

- **Config object + schema**: `fblikebutton.settings` (`config/install/fblikebutton.settings.yml`,
  `config/schema/fblikebutton.schema.yml`) — keys `node_types`, `layout`, `size`, `action`, `colorscheme`,
  `language`, `width`. → [config/settings.md](config/settings.md)
- **Settings form**: `Drupal\fblikebutton\Form\FblikebuttonFormSettings` (route `fblikebutton.settings` at
  `/admin/config/user-interface/fblikebutton`, permission `administer fblikebutton`, menu link + `configure`).
  → [config/settings.md](config/settings.md)
- **Block plugin**: `Drupal\fblikebutton\Plugin\Block\FblikebuttonBlock` (id `fblikebutton_block`, admin label
  *Facebook Like Button*) — a Like box with its own URL + appearance config. → [plugins/block.md](plugins/block.md)
- **Attach mechanism** (`fblikebutton.module`): `hook_entity_extra_field_info()` registers an extra display
  field `fblikebutton` on enabled content types; `hook_node_view()` renders it (target = node canonical URL)
  when the display component is placed and the user has `access fblikebutton`. → [behavior/attach.md](behavior/attach.md)
- **Theme + template**: `hook_theme()` registers theme hook `fblikebutton`; `templates/fblikebutton.html.twig`
  loads the FB SDK and outputs the `<div class="fb-like" data-href="…">` markup. → [behavior/attach.md](behavior/attach.md)
- **Two permissions** (`fblikebutton.permissions.yml`): `administer fblikebutton` (settings) and
  `access fblikebutton` (see the per-node button).
- **Install hook** (`fblikebutton.install`): `hook_install()` invalidates the `entity_field_info` cache tag.

## What it does NOT provide

No entities, no services, no routes beyond the settings form, no Drush, no plugin *types*, no submodules,
no third-party PHP libraries. `hook_help()` provides help text on `help.page.fblikebutton`.

## Install / operate

1. `composer require drupal/fblikebutton` then `drush en fblikebutton -y`.
2. At `/admin/config/user-interface/fblikebutton`, enable content types and set appearance (layout, size,
   action, color scheme, language, width).
3. Grant `access fblikebutton` to the roles that should see the per-node button.
4. Place the `fblikebutton` component on each content type's **Manage display** (per view mode) for the
   per-node button to render.
5. Optionally place the *Facebook Like Button* block at `/admin/structure/block` and set its URL/appearance.
