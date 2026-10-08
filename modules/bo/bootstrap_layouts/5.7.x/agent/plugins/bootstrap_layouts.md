# bootstrap_layouts — plugins

## 1. Define a custom Bootstrap layout (no PHP required)

Bootstrap layouts are plain **core Layout Discovery** plugins declared in a
`{module}.layouts.yml`, reusing this module's base class so they get the config form and
preprocessing. Copy the pattern from `bootstrap_layouts.layouts.yml`:

```yaml
my_2col_wide:
  label: 'My wide two column'
  category: 'Bootstrap'
  class: '\Drupal\bootstrap_layouts\Plugin\Layout\BootstrapLayoutsBase'
  type: partial
  icon: images/my-2col.png
  template: templates/my-2col        # a Twig template your module provides
  regions:
    left:
      label: 'Left'
      classes:
        - col-md-8
    right:
      label: 'Right'
      classes:
        - col-md-4
```

`BootstrapLayoutsManager::isBootstrapLayout($id)` returns TRUE for any layout whose plugin is an
instance of `BootstrapLayoutsBase`, and `bootstrap_layouts_theme_registry_alter()` auto-attaches
the preprocess to its theme hook — so a YAML entry using this class is fully wired up.

`BootstrapLayoutsBase` (extends `\Drupal\Core\Layout\LayoutDefault`, implements
`PluginFormInterface`) seeds each region's default config from the `classes`/`wrapper`/`attributes`
you declare, then lets the site builder override them in the UI.

## 2. Plugin types this module defines

### `bootstrap_layouts_handler` (annotation `@BootstrapLayoutsHandler`)

Manager service `plugin.manager.bootstrap_layouts` (`BootstrapLayoutsManager`), interface
`BootstrapLayoutsHandlerInterface`, base `BootstrapLayoutsHandlerBase`. A handler knows how to
**load and save** Bootstrap layout instances for one layout consumer. Built-in handlers:

- `ds` (`Plugin/BootstrapLayouts/Ds.php`) — reads/writes `EntityViewDisplay` third-party settings under `ds`.
- `page_manager` (`Plugin/BootstrapLayouts/PageManager.php`) — Panels/Page Manager variants.

Implement your own by extending `BootstrapLayoutsHandlerBase` with an `@BootstrapLayoutsHandler("my_id")`
annotation and defining `loadInstances(?array $entity_ids = NULL)` and `saveInstances(array $layouts)`
(each layout is a `\Drupal\bootstrap_layouts\BootstrapLayout` value object). The plugin id must match
an installed module/theme provider or the manager drops it (`findDefinitions()`).
`$manager->getHandlers()` returns all handler instances.

### `bootstrap_layouts_update` (annotation `@BootstrapLayoutsUpdate`)

Manager `plugin.manager.bootstrap_layouts.update` (`BootstrapLayoutsUpdateManager`), interface
`BootstrapLayoutsUpdateInterface`, base `BootstrapLayoutsUpdateBase`. Data-driven update plugins
(see `Plugin/BootstrapLayouts/Updates/`) run via `BootstrapLayoutsManager::update($schema)`, which
loads an adjoining `bootstrap_layouts.update.{schema}.yml`, calls `update()` and
`processExistingLayout()` on every stored layout, and re-saves changed instances through each handler.

## Useful manager methods (`plugin.manager.bootstrap_layouts`)

- `getClassOptions()` — the grouped class option array used by the config form (columns, hidden,
  visible, background, text color/alignment/transformation, utility).
- `isBootstrapLayout($id)` — is a given layout id one of ours.
- `getHandlers()` — all handler plugin instances.
