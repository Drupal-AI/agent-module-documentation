# jquery_ui_selectmenu — attaching the Selectmenu library

## The one thing it provides

A single asset library: **`jquery_ui_selectmenu/selectmenu`**. That is the id you attach. It
loads the minified jQuery UI Selectmenu widget plus the base selectmenu CSS theme, and pulls in
the jQuery UI Menu widget it builds on (`jquery_ui_menu/menu`) along with `core/jquery`,
`jquery_ui/widget`, `jquery_ui/position`, and the usual internal jQuery UI helper libraries.

The module ships **no `*.libraries.yml`**. The definition actually lives in the base `jquery_ui`
module, which registers the `selectmenu` library *for* this module via its
`hook_library_info_alter()`. Installing `jquery_ui_selectmenu` guarantees both of its Drupal
dependencies are present — `jquery_ui:jquery_ui (>=8.x-1.7)` and
`jquery_ui_menu:jquery_ui_menu (>=2.1)` — so the alter hook, the Menu widget, and the vendored
assets are always available.

## Attach it

From a render array (PHP):

```php
$build['#attached']['library'][] = 'jquery_ui_selectmenu/selectmenu';
```

From your own module/theme `*.libraries.yml`:

```yaml
my_module/fancy_select:
  js:
    js/my-select-init.js: {}
  dependencies:
    - jquery_ui_selectmenu/selectmenu
```

The library only ships the widget assets — it does **not** auto-initialize anything. You still
call `.selectmenu()` on a `<select>` element from your own JS (typically inside a
`Drupal.behaviors`):

```js
Drupal.behaviors.mySelect = {
  attach(context) {
    once('my-select', 'select.fancy', context).forEach((el) => jQuery(el).selectmenu());
  }
};
```

## Why this module exists

Drupal core bundled the jQuery UI Selectmenu widget inside `core/jquery.ui`, but jQuery UI is
unmaintained (End-of-Life at the OpenJS Foundation) and was deprecated and removed from core.
This module re-provides just the Selectmenu widget outside core so legacy themes, modules and
custom code keep working. It has no configuration UI, no permissions and no services. For new
work the maintainers recommend migrating off jQuery UI to a maintained alternative rather than
adding new dependencies on `jquery_ui_selectmenu/selectmenu`.
