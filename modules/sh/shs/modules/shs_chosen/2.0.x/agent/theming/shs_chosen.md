# Theming — Chosen library & Backbone overrides

## Library (`shs_chosen.libraries.yml`)

**`shs_chosen/shs_chosen.form`** — attached by the widget in
`OptionsShsChosenWidget::formElement()` (added on top of the parent's `shs/shs.form`). It loads:

- `js/views/ChosenAppView.js` and `js/views/ChosenWidgetView.js` (Backbone view overrides)

and depends on:

- `shs/shs.form` (the base SHS Backbone app)
- `chosen/drupal.chosen` (the Chosen integration from the Chosen module)
- `chosen_lib/chosen.css` (Chosen's stylesheet)

## How the Chosen styling is applied

shs_chosen does **not** replace the SHS widget; it swaps two Backbone **view** classes so the
rendered level selects are enhanced by Chosen:

`shs_chosen_shs_class_definitions_alter()` — when `chosen_override` is set and
`chosen_settings` exist, it overrides:

```
$definitions['views']['app']    = 'Drupal.shs_chosen.ChosenAppView';
$definitions['views']['widget'] = 'Drupal.shs_chosen.ChosenWidgetView';
```

`shs_chosen_shs_js_settings_alter()` then adds a `display.chosen` settings block (selector
`select.shs-select`, options taken from `chosen.settings` merged with any per-field overrides).
The `ChosenWidgetView` uses these to call Chosen on each `<select>` as levels are rendered, so
the SHS cascade and AJAX child loading stay intact while every dropdown becomes a searchable
Chosen box.

## Styling

Appearance comes from Chosen's own `chosen_lib/chosen.css`; shs_chosen ships **no CSS or theme
templates of its own**. To restyle, override Chosen's CSS in your theme, or subclass
`Drupal.shs_chosen.ChosenWidgetView` and register it through a class-definitions alter hook
(see the parent module's api doc).
