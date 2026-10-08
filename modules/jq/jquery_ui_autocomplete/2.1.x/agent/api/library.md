# Use the jQuery UI Autocomplete library

The module's only surface is the asset library `jquery_ui_autocomplete/autocomplete`. It
wraps the jQuery UI Autocomplete widget (JS/CSS) and pulls in `jquery_ui` and
`jquery_ui_menu` (the widget renders its suggestion list with the menu component).

## Attach from a render array (PHP)
```php
$build['#attached']['library'][] = 'jquery_ui_autocomplete/autocomplete';
```

## Depend on it from your own library (`mymodule.libraries.yml`)
```yaml
my-search:
  js:
    js/my-search.js: {}
  dependencies:
    - jquery_ui_autocomplete/autocomplete
```

Once attached, `jQuery.fn.autocomplete()` is available client-side (point it at a `source`
array or URL). Nothing to configure — installing the module only makes this library
declarable. Prefer native HTML autocomplete or a modern component for new code; this exists
for backward compatibility with jQuery UI.
