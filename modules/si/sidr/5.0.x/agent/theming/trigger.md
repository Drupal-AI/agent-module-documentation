# Sidr theming — the trigger template

## Theme hook `sidr_trigger`
Registered in `sidr_theme()`. Template `templates/sidr-trigger.html.twig`. Variables:
- `configuration` — the block config array.
- `options` — the derived Sidr JS options (from `getSidrJsOptions()`).
- `attributes` — button attributes (classes + `data-sidr-options`).
- `trigger_icon` — render array of the icon markup (if set).
- `trigger_text` — render array of the text (if set).

Template renders a single `<button {{ attributes }}>` with optional icon and text spans.

## `template_preprocess_sidr_trigger()`
- Sets `attributes['data-sidr-options']` = `json_encode($options)`.
- Adds classes `sidr-trigger`, `js-sidr-trigger` (plus `has-icon` / `has-text` when present).
- Wraps `trigger_icon` / `trigger_text` as `['#markup' => <block config value>]` — i.e. the icon and
  text are rendered as raw markup. These values come from the block config, which is set by users with
  block-administration rights (`administer blocks`, a `restrict access: true` permission), so this is
  trusted-admin authored markup by design (lets editors put an `<span class="icon-…">` icon in).
- Attaches libraries `sidr/behaviors` and `sidr/sidr.<global sidr_theme>`, and passes
  `drupalSettings.sidr.closeOnBlur` / `closeOnEscape` from `sidr.settings`.

## JS behavior (`sidr.js`)
Runs on elements with `.js-sidr-trigger`, reads `data-sidr-options`, and instantiates the jQuery Sidr
plugin. Any element with class `js-sidr-close` closes open panels.

## Styling
Choose the `bare` global theme to disable the packaged light/dark CSS and style
`.sidr-trigger` / the Sidr panel with your own CSS.
