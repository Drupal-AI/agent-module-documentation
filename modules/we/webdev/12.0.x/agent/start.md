<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Development (webdev) — agent index

Development-tools **meta-package** from the Webship suite. Version **12.0.1**, core `^11.4 || ^12`.
License GPL-2.0-or-later. No routes, services, permissions, or config schema of its own.

Thin PHP: `webdev.info.yml`, `webdev.install`, `recipes/default/recipe.yml`, and one shipped config
file `recipes/default/config/pathauto.pattern.content.yml`. On install `webdev_install($is_syncing)`
applies `recipes/default` (unless config is syncing / the recipe already installed it).

## What the recipe enables (installed + enabled)
ctools, token, diff, pathauto, metatag, field_group, smart_trim, entityqueue, inline_entity_form,
better_exposed_filters, link_attributes, token_filter; UI Patterns 2 (ui_patterns + _blocks, _field,
_field_formatters, _layouts, _library, _views); UI Styles (ui_styles + _block, _library, _ui_patterns);
UI Icons (ui_icons + _library, _patterns); UI Skins (ui_skins); Display Builder (display_builder +
_entity_view, _page_layout, _ui, _views); then webdev itself last.

## Available but NOT enabled by the recipe
Composer-required only (downloaded, left disabled): shield, devel, user_redirect, autocomplete_deluxe.

## Config it provisions
- Pathauto pattern `content` → `[node:title]` (`recipes/default/config/pathauto.pattern.content.yml`).
- Each enabled module's own default config (`config.import: '*'`).
- Display Builder default profile (`display_builder.profile.default`) + text format `filter.format.display_builder_html`.

## Docs
- [config/recipe.md](config/recipe.md) — full bundle list, enabled-vs-available, the Pathauto pattern, and how to operate the resulting toolset.
