<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The CKEditor 5 "Augmentors" plugin

## Install & enable

```bash
drush en augmentor_ckeditor5 -y
```

Dependencies: core **`ckeditor5`** and the parent **`augmentor`** module. No sub-modules,
permissions, Drush commands of its own. Provides a config schema. Replaces the deprecated
`augmentor_ckeditor4`.

## Add the button to a text format

1. Configure augmentors in the parent module at **`/admin/config/augmentors`**
   (needs `administer augmentor`).
2. **Configuration → Content authoring → Text formats and editors**, edit a **CKEditor 5** format,
   drag **Augmentors** into the *Active toolbar*.
3. In the plugin's settings (the *Augmentors* vertical tab that appears once the button is active),
   tick the augmentors to expose. Save.

The toolbar button (and its whole plugin) is only visible to users who hold the parent permission
**`execute augmentor`** — see permission gating below.

## Definition & files

- `augmentor_ckeditor5.ckeditor5.yml` → plugin **`augmentor_ckeditor5_augmentor`**: CKEditor5
  plugin `augmentor.augmentor`, `drupal.label` *"Augmentors"*, `toolbar_items.augmentor`,
  `library: augmentor_ckeditor5/augmentor`, `admin_library: augmentor_ckeditor5/admin.augmentor`,
  `elements: false`, `class: Drupal\augmentor_ckeditor5\Plugin\CKEditor5Plugin\Augmentor`.
- Config schema `config/schema/augmentor_ckeditor5.schema.yml`:
  `ckeditor5.plugin.augmentor_ckeditor5_augmentor` → `augmentors` (a `sequence` of strings).
- Libraries (`augmentor_ckeditor5.libraries.yml`): `augmentor` (built JS `js/build/augmentor.js`,
  `minified: true`, depends `core/ckeditor5`) and `admin.augmentor` (`css/augmentor.css`).
- Icon `icons/augmentor.svg`; JS sources `js/ckeditor5_plugins/augmentor/src/` (built with the
  bundled `webpack.config.js` / `package.json`).

## Permission gating (`AugmentorCkeditor5Hooks.php`)

`hook_ckeditor5_plugin_info_alter()` (attribute `#[Hook('ckeditor5_plugin_info_alter')]`, invoked
via the `#[LegacyHook]` shim in `augmentor_ckeditor5.module`):

```php
$user = \Drupal::currentUser();
if (!$user->hasPermission("execute augmentor")) {
  unset($plugin_definitions['augmentor_ckeditor5_augmentor']);
}
```

So the plugin is removed from CKEditor 5 entirely for users lacking `execute augmentor`; the parent
execute route enforces the same permission server-side.

## PHP plugin class (`Augmentor.php`)

Extends `CKEditor5PluginDefault`, implements `CKEditor5PluginConfigurableInterface`
(`CKEditor5PluginConfigurableTrait`) and `ContainerFactoryPluginInterface`. Injects
`AugmentorManager` (`plugin.manager.augmentor.augmentors`) and caches
`AugmentorManager::getAugmentors()`.

| Method | Behaviour |
|---|---|
| `defaultConfiguration()` | `['augmentors' => []]`. |
| `buildConfigurationForm()` | One checkbox per augmentor; default checked when its uuid is already in `configuration['augmentors']`. |
| `submitConfigurationForm()` | For each submitted value that matches a known augmentor uuid, stores `configuration['augmentors'][$uuid] = $label`. |
| `getDynamicPluginConfig()` | Merges stored config over the static config, runs `cleanUpAugmentors()`, returns `['augmentors' => [$dynamic_config]]` for the JS. |
| `cleanUpAugmentors()` | Unsets any augmentor id that `AugmentorManager::getAugmentor()` no longer resolves. |

Stored per-format config shape (schema-backed):

```yaml
# in the editor entity's settings.plugins
augmentor_ckeditor5_augmentor:
  augmentors:
    <augmentor-uuid>: 'Human label'
```

## Runtime flow (JS, `js/ckeditor5_plugins/augmentor/src/`)

- `augmentor.js` — plugin requiring `augmentorUI` + core `ContextualBalloon`.
- `augmentorui.js` — reads `editor.config.get('augmentors')[0].augmentors`, registers command
  `executeCommand`, and builds a `createDropdown`/`addListToDropdown` toolbar dropdown (one button
  per augmentor, keyed by uuid). On `execute` it shows
  `Drupal.theme.ajaxProgressIndicatorFullscreen()` then `editor.execute('executeCommand', id)`.
- `execute/executecommand.js` (`ExecuteCommand extends Command`) —
  1. gathers `selectedText` from the model selection ranges and the last selection position;
  2. `fetch(drupalSettings.path.baseUrl + 'augmentor/execute/augmentor', {method:'POST',
     credentials:'same-origin', body: JSON.stringify({input, augmentor: id, type:'ckeditor'})})`;
  3. on OK, `_updateCkeditor()` builds `"<br/>" + output.default.toString()`, replaces `\n` with
     `<br/>`, converts it via `editor.data.processor.toView()` → `editor.data.toModel()` and
     `editor.model.insertContent(modelFragment, position)` at the saved position;
  4. errors go to `_showError()` → `new Drupal.Message()`.

The `fetch` target is the **parent** route `augmentor.augmentor_execute`
(`\Drupal\augmentor\Controller\AugmentorController::execute`, requirement
`_permission: 'execute augmentor'`). All provider selection, API-key/Key handling and output
shaping happen in that controller; this submodule only sends the selection and renders the result.
Inserted output is parsed through CKEditor 5's data processor/schema and is re-filtered by the text
format on save.

## Notes

- The dropdown lists augmentors by the labels captured at config-save time; renaming an augmentor in
  the parent UI updates the runtime list after a cache rebuild (labels in stored config refresh via
  `getDynamicPluginConfig`/`cleanUpAugmentors`).
- Output is inserted at the last selection position, not appended at the end (contrast the CKEditor 4
  submodule).
