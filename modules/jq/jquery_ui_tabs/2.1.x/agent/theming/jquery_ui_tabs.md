# jquery_ui_tabs — attaching the Tabs library

## The one thing it provides

A single asset library: **`jquery_ui_tabs/tabs`**. That is the id you attach. It loads the
minified jQuery UI Tabs widget (`assets/vendor/jquery.ui/ui/widgets/tabs-min.js`, jQuery UI
1.13.2) and the base `tabs.css` theme (`component` group), and pulls in these dependencies:
`core/jquery`, `jquery_ui/widget`, and the internal helpers `jquery_ui/internal.keycode`,
`jquery_ui/internal.safe-active-element`, `jquery_ui/internal.unique-id`,
`jquery_ui/internal.version`, `jquery_ui/internal.widget-css`.

The module ships **no `*.libraries.yml`**. The definition actually lives in the base `jquery_ui`
module, which registers the `tabs` library *for* this module via its
`hook_library_info_alter()` (reading `jquery_ui.libraries.data.json`). Installing
`jquery_ui_tabs` guarantees `jquery_ui` is present (its only Drupal dependency,
`jquery_ui:jquery_ui (>=8.x-1.7)`), so the alter hook and vendored assets are always available.

## Attach it

From a render array (PHP):

```php
$build['#attached']['library'][] = 'jquery_ui_tabs/tabs';
```

From your own module/theme `*.libraries.yml`:

```yaml
my_module/tabs_ui:
  js:
    js/my-tabs-init.js: {}
  dependencies:
    - jquery_ui_tabs/tabs
```

The library only ships the widget assets — it does **not** auto-initialize anything. You still
call `.tabs()` on your markup from your own JS (typically inside a `Drupal.behaviors`):

```js
Drupal.behaviors.myTabs = {
  attach(context) {
    once('my-tabs', '#my-tabs', context).forEach((el) => jQuery(el).tabs());
  }
};
```

## Why this module exists

Drupal core bundled the jQuery UI Tabs widget inside `core/jquery.ui`, but jQuery UI is
unmaintained (End-of-Life at the OpenJS Foundation) and was deprecated and removed from core.
This module re-provides just the Tabs widget outside core so legacy themes, modules and custom
code keep working. It has no configuration UI, no permissions and no services. For new work the
maintainers recommend migrating off jQuery UI to a maintained alternative rather than adding new
dependencies on `jquery_ui_tabs/tabs`.
