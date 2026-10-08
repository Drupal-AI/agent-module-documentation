# Theming

## Theme hooks (`ui_icons_theme()`)

- `icon_selector` — wraps the `icon_autocomplete` element.
  Template: `templates/icon-selector.html.twig`. Render element: `element`.
  Preprocessed by `template_preprocess_icon_selector()`, which exposes
  `has_settings`, `icon_form`, `settings_form`, and resolved `pack_id` / `icon_id`.
- `icon_preview` — renders a single icon preview.
  Template: `templates/icon-preview.html.twig`.
  Variables: `pack_id`, `icon_id`, `icon_label`, `extractor`, `source`, `library`,
  `settings`.

## Per-pack icon templates

The actual icon markup is NOT a fixed template — each icon pack supplies its own
`template:` (and optional `preview:`) Twig string in its `*.icons.yml`. See
[../plugins/icon-plugins.md](../plugins/icon-plugins.md).

## Libraries (`ui_icons.libraries.yml`)

- `ui_icons/ui_icons.autocomplete` — base autocomplete JS/CSS (attached automatically).
- `ui_icons/ui_icons.preview` — live preview JS.
- Theme-specific autocomplete skins, auto-attached in
  `template_preprocess_icon_selector()` when the matching theme is active:
  `ui_icons.gin_autocomplete` (Gin), `ui_icons.daisyui_autocomplete`
  (ui_suite_daisyui), `ui_icons.dsfr_autocomplete` (ui_suite_dsfr).

## Twig function

`{{ icon_preview(pack_id, icon_id, settings) }}` renders an icon inline in any
template (see [../api/services.md](../api/services.md)).
