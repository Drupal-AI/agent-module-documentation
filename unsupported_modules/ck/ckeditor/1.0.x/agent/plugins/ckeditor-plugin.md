<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Implement a CKEditor 4 plugin (`@CKEditorPlugin`)

This module defines the `CKEditorPlugin` plugin type (identical to core CKEditor 4). Use it to expose a
CKEditor 4 JS plugin to Drupal — add a toolbar button, load a JS file, inject config, or add CSS.

- **Manager:** `plugin.manager.ckeditor.plugin` (`CKEditorPluginManager`, extends
  `DefaultPluginManager`).
- **Discovery:** class in `src/Plugin/CKEditorPlugin/`, annotation `@CKEditorPlugin`.
- **Annotation fields:** `id` (MUST equal the CKEditor JS plugin name, or CKEditor throws JS errors),
  `label`.
- **Base class:** `CKEditorPluginBase` (already implements `CKEditorPluginInterface` +
  `CKEditorPluginButtonsInterface`).
- **Alter hook:** `hook_ckeditor_plugin_info_alter` (see [hooks](../hooks/hooks.md)).

## Interfaces

| Interface | Method | Purpose |
|---|---|---|
| `CKEditorPluginInterface` | `isInternal()`, `getDependencies(Editor)`, `getLibraries(Editor)`, `getFile()`, `getConfig(Editor)` | Core contract: is it part of the build, other CKEditor plugins it needs, Drupal asset libraries, path to the plugin JS file, and CKEditor config to merge. |
| `CKEditorPluginButtonsInterface` | `getButtons()` | Declare toolbar buttons (`['MyButton' => ['label' => …, 'image' => …]]`). A button-providing plugin is **enabled when at least one of its buttons is in the toolbar**. |
| `CKEditorPluginContextualInterface` | `isEnabled(Editor)` | Enable the plugin without a toolbar button (e.g. always-on behavior). |
| `CKEditorPluginConfigurableInterface` | `settingsForm(array, FormStateInterface, Editor)` | Add a per-editor settings form (values stored under `settings.plugins.<id>`). |
| `CKEditorPluginCssInterface` | `getCssFiles(Editor)` | Add CSS files to the iframe editing area. |

Enablement logic (`CKEditorPluginManager::getEnabledPluginFiles`): buttons-plugin → enabled if a button
is on the toolbar; contextual-plugin → enabled if `isEnabled()` is TRUE; both → either. `internal`
plugins (`isInternal()===TRUE`, part of the bundled build) are excluded unless explicitly requested.

## Minimal example

```php
namespace Drupal\mymodule\Plugin\CKEditorPlugin;

use Drupal\ckeditor\CKEditorPluginBase;
use Drupal\editor\Entity\Editor;

/**
 * @CKEditorPlugin(
 *   id = "myplugin",              // == the CKEditor JS plugin name
 *   label = @Translation("My plugin")
 * )
 */
class MyPlugin extends CKEditorPluginBase {

  public function isInternal() { return FALSE; }

  public function getFile() {
    return \Drupal::service('extension.list.module')->getPath('mymodule') . '/js/plugins/myplugin/plugin.js';
  }

  public function getConfig(Editor $editor) { return []; }

  public function getButtons() {
    return [
      'MyButton' => [
        'label' => $this->t('My button'),
        'image' => \Drupal::service('extension.list.module')->getPath('mymodule') . '/js/plugins/myplugin/icon.png',
      ],
    ];
  }
}
```

The `plugin.js` must register a CKEditor plugin whose name matches the annotation `id`. See the shipped
plugins for full examples: `src/Plugin/CKEditorPlugin/DrupalImage.php` (buttons + config + dialog),
`StylesCombo.php` (`Configurable`), `Language.php` (`Configurable` + `Css`), `Internal.php`
(`isInternal()===TRUE`), `DrupalMediaLibrary.php`, `DrupalLink.php`, `DrupalImageCaption.php`,
`DrupalMedia.php`.
