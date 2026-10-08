# UI Icons (ui_icons) — agent index

Generic icon manager. The base module (`ui_icons`) is **only the autocomplete form
element** plus its services; it has **no config UI, no permissions, no Drush**. It provides
the `icon_autocomplete` form element, an icon search/preview API, and Twig helpers on top of
Drupal core's Icon API. Icon packs are declared in `EXTENSION_NAME.icons.yml`; icons are
addressed as `pack_id:icon_id`. Requires Drupal `^11.3 || ^12.0`.

Routes (both `access content`): `ui_icons.autocomplete`
(`/ui-icons/ajax/autocomplete/icons`, GET, `q`/`allowed_icon_pack`/`result_format`/`max_result`
query params), `ui_icons.preview` (`/ui-icons/ajax/preview/icons`, POST, JSON body
`{icon_full_ids, settings}`). No `configure` route.

- Declare/consume icon packs & extractor plugins → [plugins/icon-plugins.md](plugins/icon-plugins.md)
- Form element, search & preview services, Twig function → [api/services.md](api/services.md)
- Templates, theme hooks & theme-specific styling → [theming/theming.md](theming/theming.md)
- Submodules (field + linkit/attributes, canvas, media, ckeditor5, menu, font, picker,
  library, patterns, text) → listed in `../data.json` `submodules`; each adds one
  integration surface.

Changed since 1.1.x: Drupal 12 support and floor raised to 11.3; base module renamed to
"UI Icons Form element"; new `ui_icons_canvas` submodule; placeholder submodules
`ui_icons_backport` and `ui_icons_iconify_api` removed (update hook `ui_icons_update_11201`);
`ui_icons_patterns` is UI Patterns 2.x only; icon field declares `target_id` as main property.
