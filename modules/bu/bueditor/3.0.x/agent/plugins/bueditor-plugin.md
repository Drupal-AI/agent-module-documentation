# BUEditor — `bueditor_plugin` plugin type

Plugins contribute toolbar buttons and can alter the editor's JS data, the toolbar widget, and the
editor entity form.

## Type wiring

- Manager service `plugin.manager.bueditor.plugin` → `BUEditorPluginManager` (parent
  `default_plugin_manager`).
- Namespace `Plugin/BUEditorPlugin`; interface `BUEditorPluginInterface`; base
  `BUEditorPluginBase`; annotation `@BUEditorPlugin` (`id`, `label`, `weight` — sorted by weight);
  alter hook `bueditor_plugin_info`; cache key `bueditor_plugins`.
- Manager fan-out helpers: `getButtons()` / `getButtonGroups()`, `invokeAll($hook, …)`,
  `alterEditorJs()`, `alterToolbarWidget()`, `alterEditorForm()`, `validateEditorForm()`.

## Interface (`BUEditorPluginInterface`)

```php
public function getButtons();                                   // ['id' => label, ...]
public function alterEditorJs(array &$js, BUEditorEditor $e, ?Editor $editor = NULL);
public function alterToolbarWidget(array &$widget);            // 'libraries' + 'items'
public function alterEditorForm(array &$form, FormStateInterface $fs, BUEditorEditor $e);
public function validateEditorForm(array &$form, FormStateInterface $fs, BUEditorEditor $e);
```

`$js` holds `libraries` and `settings` (incl. `settings['toolbar']`, wrappable with
`BUEditorToolbarWrapper::set()` → `has()`/`remove()`).

## Bundled plugins (`Plugin/BUEditorPlugin/`)

- **`core`** (`Core`) — the standard button set.
- **`xpreview`** (`XPreview`) — adds an Ajax "Preview" button (`xpreview`). In `alterEditorJs()` it
  only attaches the `bueditor/drupal.bueditor.xpreview` library when the current user has
  `access ajax preview`; otherwise it removes the button from the toolbar. `validateEditorForm()`
  warns when the preview button is newly enabled to check permissions. The button posts to
  `/xpreview` (see permissions/permissions.md).

## Implementing a plugin

```php
/**
 * @BUEditorPlugin(id = "myplugin", label = @Translation("My plugin"), weight = 10)
 */
class MyPlugin extends BUEditorPluginBase {
  public function getButtons() {
    return ['mybtn' => $this->t('My button')];
  }
  public function alterEditorJs(array &$js, BUEditorEditor $e, ?Editor $editor = NULL) {
    // add libraries / tweak $js['settings'] when the button is in the toolbar
  }
}
```

Place the class in `MyModule/src/Plugin/BUEditorPlugin/`. Only the methods you need must do work;
`BUEditorPluginBase` provides no-op defaults.
