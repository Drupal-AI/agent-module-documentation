# Attach the jQuery UI Accordion library

The module's only capability is exposing the asset library. Attach it, then
initialize the widget in your own JavaScript.

## Attach in a render array
```php
$build['content'] = [
  '#type' => 'markup',
  '#markup' => $html,               // your accordion markup (headers + panels)
  '#attached' => [
    'library' => ['jquery_ui_accordion/accordion'],
  ],
];
```

## Initialize in JS
```js
(function ($, Drupal) {
  Drupal.behaviors.myAccordion = {
    attach: function (context) {
      $(once('myAccordion', '#my-accordion', context)).accordion({
        collapsible: true,
        heightStyle: 'content',
      });
    },
  };
})(jQuery, Drupal);
```

Notes:
- The underlying jQuery UI assets come from the base `jquery_ui` module (this module
  only re-exposes the accordion library).
- jQuery UI is no longer actively developed upstream; use this as a compatibility
  bridge, not a foundation for new UI work.
- Markup convention: alternating header elements (e.g. `<h3>`) and content `<div>`s
  inside the container you call `.accordion()` on.
