# Theming — the `svg_icon()` Twig function

## Twig function

Provided by `Drupal\icon_select\Twig\Extension\IconSelectExtension` (service
`icon_select.twig.extension`, tagged `twig.extension`):

```twig
{{ svg_icon(symbol_id, classes) }}
```

- `symbol_id` (string) — the icon term's `field_symbol_id`.
- `classes` (optional) — a string or array of CSS classes.

Example:

```twig
{{ svg_icon('ui-check') }}
{{ svg_icon('ui-check', 'icon--large') }}
```

The function returns a render array using the `icon_select_svg_icon` theme hook. It always adds
the classes `icon` and `icon--<symbol_id>` (e.g. `icon--ui-check`), so you can target icons in
CSS by symbol.

## Theme hook & template

- Theme hook: `icon_select_svg_icon` — variables `attributes` and `symbol_id`.
- Template: `templates/icon-select-svg-icon.html.twig` (outputs `<svg><use xlink:href="#{{ symbol_id }}">`).
- `icon_select_preprocess_icon_select_svg_icon()` attaches `icon_select/drupal.icon_select_frontend`
  (and, for authenticated users, `…_backend`).
- `icon_select_preprocess_page()` publishes the sprite URL (with a cache-busting `?hash=` from
  `State('icon_select_hash')`) to `drupalSettings.icon_select.icon_select_url` so JS can fetch it.

Rendered markup references symbols in the generated sprite at `public://icons/icon_select_map.svg`,
so the referenced `symbol_id` must exist as an icon term (and the sprite must be current — see
[../drush/generate-sprites.md](../drush/generate-sprites.md)).
