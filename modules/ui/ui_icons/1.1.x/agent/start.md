# UI Icons (ui_icons) — agent index

Generic icon manager. The base module has **no config UI, no permissions, no Drush**.
It provides the `icon_autocomplete` form element, an icon search/preview API, and Twig
helpers on top of Drupal core's Icon API (11.1+). Icon packs are declared in
`EXTENSION_NAME.icons.yml`; icons are addressed as `pack_id:icon_id`.

Routes (both AJAX, `access content`): `ui_icons.autocomplete`
(`/ui-icons/ajax/autocomplete/icons`), `ui_icons.preview`
(`/ui-icons/ajax/preview/icons`, POST). No `configure` route.

- Declare/consume icon packs & extractor plugins → [plugins/icon-plugins.md](plugins/icon-plugins.md)
- Form element, search & preview services, Twig function → [api/services.md](api/services.md)
- Templates, theme hooks & theme-specific styling → [theming/theming.md](theming/theming.md)
- Submodules (field, media, ckeditor5, menu, font, picker, library, patterns, text) →
  listed in `../data.json` `submodules`; each adds one integration surface.
