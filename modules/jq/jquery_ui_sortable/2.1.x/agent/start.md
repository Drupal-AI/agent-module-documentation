# jquery_ui_sortable — agent start

Compatibility shim: provides the **jQuery UI Sortable** asset library (removed from core)
as the Drupal library `jquery_ui_sortable/sortable`. Depends on the `jquery_ui` module,
which vendors the real files and fills in the empty library definition. No config, no
`configure` route, no permissions, no services, no plugins, no PHP API.

Attach it where you need drag-and-drop reordering:

```php
$build['#attached']['library'][] = 'jquery_ui_sortable/sortable';
```

Or list it under `dependencies:` in a theme/module `*.libraries.yml`. Migrating from old
core code means replacing `core/jquery.ui.sortable` with `jquery_ui_sortable/sortable`.

- **The library id, how to attach it, and what it replaces** → [api/library.md](api/library.md)

Note: jQuery UI is end-of-life. Prefer SortableJS (core's replacement) for new code; this
module only keeps legacy code alive.
