# Plugin type: CKEditorPlugin

The module defines the CKEditor 4 plugin type (the same one the removed core `ckeditor`
module had). Use it to register CKEditor 4 plugins — toolbar buttons, contextually-loaded
behaviour, iframe CSS — for text formats that use the `ckeditor` editor.

| Facet | Value |
|-------|-------|
| Annotation | `@CKEditorPlugin` (`Drupal\ckeditor\Annotation\CKEditorPlugin`) — properties `id`, `label` |
| Discovery namespace | `Plugin/CKEditorPlugin` |
| Interface | `Drupal\ckeditor\CKEditorPluginInterface` |
| Base class | `Drupal\ckeditor\CKEditorPluginBase` |
| Manager service | `plugin.manager.ckeditor.plugin` (class `Drupal\ckeditor\CKEditorPluginManager`) |
| Alter hook | `hook_ckeditor_plugin_info_alter(array &$plugins)` (alter id `ckeditor_plugin_info`) |
| Cache tag / bin key | `ckeditor_plugins` |

The plugin `id` **MUST match the CKEditor JavaScript plugin name** it loads, or CKEditor throws
JS errors when it fails to find the plugin.

## Optional capability interfaces

Implement whichever apply, on top of `CKEditorPluginInterface` (`getFile()`, `getConfig()`,
`getDependencies()`, `getLibraries()`, `isInternal()`):

| Interface | Adds | Meaning |
|-----------|------|---------|
| `CKEditorPluginButtonsInterface` | `getButtons()` | Plugin provides toolbar buttons; enabled when at least one of its buttons is in the toolbar. |
| `CKEditorPluginContextualInterface` | `isEnabled(Editor $editor)` | Plugin decides its own enablement (no button). |
| `CKEditorPluginConfigurableInterface` | `settingsForm()` | Plugin exposes a per-format settings form. |
| `CKEditorPluginCssInterface` | `getCssFiles(Editor $editor)` | Plugin contributes iframe CSS. |

## How enablement is resolved

`CKEditorPluginManager::getEnabledPluginFiles(Editor $editor, $include_internal = FALSE)`
returns enabled plugins keyed by id → Drupal-root-relative JS file. A plugin is enabled when:
one of its `getButtons()` keys is present in the toolbar, **or** its `isEnabled()` returns TRUE.
Dependencies returned by `getDependencies()` are pulled in transitively. Internal plugins
(`isInternal()` TRUE) are excluded unless `$include_internal` is TRUE — the editor plugin's
`getJSSettings()` passes TRUE so internal plugins load implicitly.

## Bundled plugins (`src/Plugin/CKEditorPlugin/`)

`Internal`, `DrupalImage`, `DrupalImageCaption`, `DrupalLink`, `DrupalMedia`,
`DrupalMediaLibrary`, `Language`, `StylesCombo`. `DrupalMediaLibrary`'s "Insert from Media
Library" button additionally requires the `media_embed` filter (enforced by a filter-format
form validate handler — see [api/integration.md](../api/integration.md)).

## Minimal plugin

```php
namespace Drupal\my_module\Plugin\CKEditorPlugin;

use Drupal\ckeditor\CKEditorPluginBase;
use Drupal\ckeditor\CKEditorPluginButtonsInterface;
use Drupal\editor\Entity\Editor;

/**
 * @CKEditorPlugin(
 *   id = "myfeature",
 *   label = @Translation("My feature")
 * )
 */
class MyFeature extends CKEditorPluginBase implements CKEditorPluginButtonsInterface {

  public function getFile() {
    return \Drupal::service('extension.list.module')->getPath('my_module') . '/js/plugins/myfeature/plugin.js';
  }

  public function getButtons() {
    return ['MyButton' => ['label' => $this->t('My button')]];
  }

  public function getConfig(Editor $editor) {
    return [];
  }
}
```

The JS file must define a CKEditor plugin named `myfeature` (matching the annotation `id`).
