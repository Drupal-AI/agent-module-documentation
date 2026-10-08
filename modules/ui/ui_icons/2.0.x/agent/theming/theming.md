# Theming

## Theme hooks (`\Drupal\ui_icons\Hook\UiIconsHooks::theme()`, `#[Hook('theme')]`)

- `icon_selector` — wraps the `icon_autocomplete` element.
  Template: `templates/icon-selector.html.twig`. Render element: `element`.
  Preprocessed by `UiIconsHooks::preprocessIconSelector()` (`#[Hook('preprocess_icon_selector')]`),
  which exposes `has_settings`, `icon_form`, `settings_form`, and resolved `pack_id` / `icon_id`.
- `icon_preview` — renders a single icon preview.
  Template: `templates/icon-preview.html.twig`.
  Variables: `pack_id`, `icon_id`, `icon_label`, `extractor`, `source`, `library`, `settings`.

All hooks are `#[Hook]` attribute methods on `UiIconsHooks` (no `.module` file);
`help`, `theme`, and `preprocess_icon_selector` are the only ones.

## Per-pack icon templates

The actual icon markup is NOT a fixed template — each icon pack supplies its own
`template:` (and optional `preview:`) Twig string in its `*.icons.yml`. See
[../plugins/icon-plugins.md](../plugins/icon-plugins.md).

## Libraries (`ui_icons.libraries.yml`)

- `ui_icons/ui_icons.autocomplete` — base autocomplete JS/CSS (attached automatically).
- `ui_icons/ui_icons.preview` — live preview JS.
- Theme-specific autocomplete skins, auto-attached in `preprocessIconSelector()` when the
  matching theme (or a sub-theme of it) is active, keyed by theme name:
  `default_admin` → `ui_icons.default_admin_autocomplete`, `gin` → `ui_icons.gin_autocomplete`,
  `ui_suite_daisyui` → `ui_icons.daisyui_autocomplete`, `ui_suite_dsfr` → `ui_icons.dsfr_autocomplete`.

## Twig function

`{{ icon_preview(pack_id, icon_id, settings) }}` renders an icon inline in any
template (see [../api/services.md](../api/services.md)).
