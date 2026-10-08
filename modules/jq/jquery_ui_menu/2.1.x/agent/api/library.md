# Use the jQuery UI Menu library

The module's only surface is the asset library `jquery_ui_menu/menu`. It wraps the
jQuery UI Menu widget (JS/CSS) and pulls in the base `jquery_ui` assets it needs.

## Attach from a render array (PHP)
```php
$build['#attached']['library'][] = 'jquery_ui_menu/menu';
```

## Depend on it from your own library (`mymodule.libraries.yml`)
```yaml
my-widget:
  js:
    js/my-widget.js: {}
  dependencies:
    - jquery_ui_menu/menu
```

Once attached, `jQuery.fn.menu()` is available client-side. There is nothing to configure;
installing the module only makes this library declarable. Prefer native/modern JS for new
code — this exists for backward compatibility with code written against jQuery UI.
