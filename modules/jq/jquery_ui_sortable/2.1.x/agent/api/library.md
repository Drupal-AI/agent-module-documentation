# jquery_ui_sortable — the library

## The one thing this module provides

An asset library id: **`jquery_ui_sortable/sortable`**.

`jquery_ui_sortable.libraries.yml` declares it as an *empty* stub:

```yaml
# This empty library definition will be filled in by the jquery_ui module.
sortable:
  js: {}
```

The base **`jquery_ui`** module (dependency, `>=8.x-1.7`) discovers this stub and injects the
real vendored asset at build time. On a live site the resolved library loads:

```
modules/contrib/jquery_ui/assets/vendor/jquery.ui/ui/widgets/sortable-min.js  (jQuery UI 1.13.2)
```

## Attaching it

Render array:

```php
$build['#attached']['library'][] = 'jquery_ui_sortable/sortable';
```

From a hook, site-wide:

```php
function mymodule_page_attachments(array &$attachments) {
  $attachments['#attached']['library'][] = 'jquery_ui_sortable/sortable';
}
```

As a dependency in your `mytheme.libraries.yml` / `mymodule.libraries.yml`:

```yaml
my_widget:
  js:
    js/my-widget.js: {}
  dependencies:
    - jquery_ui_sortable/sortable
```

## Migrating legacy code

Replace the removed core library reference:

| Old (removed from core) | New (this module) |
|---|---|
| `core/jquery.ui.sortable` | `jquery_ui_sortable/sortable` |

That is the entire migration — the JavaScript API (`$('...').sortable({...})`, events
`start` / `update` / `stop`, connected lists via `connectWith`) is unchanged because the
underlying vendored jQuery UI files are identical.

## What it does NOT provide

No `configure` route, no config schema, no permissions, no services, no plugin types, no
Drush commands, no `*.api.php` hooks. Enabling the module (and `jquery_ui`) is all that is
required for the library to resolve; there is nothing else to set up or extend.
