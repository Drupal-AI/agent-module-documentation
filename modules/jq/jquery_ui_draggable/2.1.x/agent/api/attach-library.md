# Attach the draggable library

The module exposes exactly one asset library: `jquery_ui_draggable/draggable`. There is no
PHP service or config — you consume it by attaching the library, then calling jQuery UI's
`.draggable()` in your own JS.

## Depend on it from your own library

In `mymodule.libraries.yml`:

```yaml
my_ui:
  js:
    js/my-ui.js: {}
  dependencies:
    - jquery_ui_draggable/draggable
```

## Attach it in a render array

```php
$build['#attached']['library'][] = 'jquery_ui_draggable/draggable';
```

## Migrate legacy code

Replace any core dependency `core/jquery.ui.draggable` with `jquery_ui_draggable/draggable`
(and enable the `jquery_ui` + `jquery_ui_draggable` modules).

## Use it in JavaScript

```js
(function ($, Drupal) {
  Drupal.behaviors.myDraggable = {
    attach: function (context) {
      $('.my-panel', context).draggable({ handle: '.my-panel__header' });
    }
  };
})(jQuery, Drupal);
```

Note: jQuery UI is End of Life; treat this as a compatibility bridge.
