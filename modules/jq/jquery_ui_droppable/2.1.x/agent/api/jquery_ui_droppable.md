# Attaching jQuery UI Droppable

The module declares one asset library: **`jquery_ui_droppable/droppable`**. The
`jquery_ui_droppable.libraries.yml` file ships an intentionally empty definition
(`droppable: { js: {} }`) — its contents are filled in at runtime by the base `jquery_ui`
module. There is no config, no permissions, no services and no plugins.

## Why this module exists

Drupal core used to bundle this as `core/jquery.ui.droppable`. jQuery UI is End of Life
(OpenJS Foundation) and was deprecated/removed from core, so this contrib module re-provides
the same library outside of core. See the change record: https://www.drupal.org/node/3067969.

## Attach from PHP (render array)

```php
$build['#attached']['library'][] = 'jquery_ui_droppable/droppable';
```

## Depend on it from your own *.libraries.yml

```yaml
my_module/my_lib:
  js:
    js/my-drop-zone.js: {}
  dependencies:
    - jquery_ui_droppable/droppable
```

## Migrate legacy code

Replace old core references with the contrib library:

- `core/jquery.ui.droppable` → `jquery_ui_droppable/droppable`

## Dependencies

Declared in `jquery_ui_droppable.info.yml` and `composer.json`:

- `jquery_ui` (>=8.x-1.7 / `drupal/jquery_ui:^1.7`) — the base that fills in the library.
- `jquery_ui_draggable` (>=2.1 / `drupal/jquery_ui_draggable:^2.1`) — droppable drop targets
  need draggable items to accept.

Install all three modules, then attach `jquery_ui_droppable/droppable` where you need it.
Prefer migrating to a maintained drag-and-drop library for new code.
