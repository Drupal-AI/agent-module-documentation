# Attach the jQuery UI Controlgroup library

The module's only capability is exposing the asset library
`jquery_ui_controlgroup/controlgroup`. Attach it, then initialize the widget in your own
JavaScript.

## Attach in a render array
```php
$build['content'] = [
  '#type' => 'markup',
  '#markup' => $html,               // your grouped controls (buttons / inputs)
  '#attached' => [
    'library' => ['jquery_ui_controlgroup/controlgroup'],
  ],
];
```

## Depend on it from your own *.libraries.yml
```yaml
my_widget:
  version: 1.x
  js:
    js/my-widget.js: {}
  dependencies:
    - jquery_ui_controlgroup/controlgroup
```

## Initialize in JS
```js
(function ($, Drupal) {
  Drupal.behaviors.myControlgroup = {
    attach: function (context) {
      $(once('myControlgroup', '.my-controls', context)).controlgroup({
        direction: 'horizontal',   // or 'vertical'
      });
    },
  };
})(jQuery, Drupal);
```

## Library facts (live registry)
- Library id: `jquery_ui_controlgroup/controlgroup` (jQuery UI 1.13.2).
- JS: `controlgroup-min.js`; CSS: `controlgroup.css` — both served from the base
  `jquery_ui` module (`modules/contrib/jquery_ui/assets/vendor/jquery.ui/...`), not from
  this module.
- Auto-attached dependencies: `core/jquery`, `jquery_ui/widget`,
  `jquery_ui/internal.widget-css`.

Notes:
- The underlying jQuery UI assets come from the base `jquery_ui` module (this module only
  re-exposes the controlgroup library), so `jquery_ui` must be enabled — it is a hard
  module dependency.
- jQuery UI is no longer actively developed upstream; use this as a compatibility bridge,
  not a foundation for new UI work.
- Controlgroup pairs well with `jquery_ui_checkboxradio` when grouping styled radios and
  checkboxes.
