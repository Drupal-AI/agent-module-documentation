<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 4 Augmentor (augmentor_ckeditor4) — agent index

Submodule of **augmentor**. Adds an **"Augmentors" dropdown button** to the **CKEditor 4** toolbar
that runs a chosen augmentor on the selected text. Package `Augmentor`. Core
`^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.2.x.

**Deprecated** (`lifecycle: deprecated`, see drupal.org issue 3469771) — superseded by
[augmentor_ckeditor5](../../augmentor_ckeditor5/1.2.x/agent/start.md). Depends on core
**`ckeditor`** and **`augmentor`**.

- **The CKEditor plugin, its settings form, and the execute request flow** →
  [plugins/ckeditor-button.md](plugins/ckeditor-button.md)

## What it actually is

- One CKEditor 4 plugin: `AugmentorCKEditor` (id **`augmentor_ckeditor`**, label *"Augmentor"*),
  `src/Plugin/CKEditorPlugin/AugmentorCKEditor.php`, extending `CKEditorPluginBase` and
  implementing `CKEditorPluginConfigurableInterface` + `ContainerFactoryPluginInterface`.
- One JS file `js/plugins/augmentor_ckeditor/plugin.js` (a `CKEDITOR.plugins.add('augmentor_ckeditor')`
  rich-combo), a CSS library `augmentor_ckeditor4/augmentor_ckeditor` (`css/augmentor_ckeditor.css`,
  declared in `augmentor_ckeditor4.libraries.yml`) and a toolbar icon `images/augmentor_icon.png`.
- **No routes, no controller, no permissions, no config schema, no services, no hooks, no Drush** of
  its own. It calls the **parent** route `augmentor.augmentor_execute`
  (`/augmentor/execute/augmentor`), which is gated by the parent permission
  **`execute augmentor`**.

## Mechanism (from source)

- `getButtons()` registers one toolbar button (`augmentor_ckeditor`, label *"Augmentors"*) rendered
  as a dropdown via an inline-template `image_alternative`.
- `getConfig()` injects two JS settings: `augmentor_ckeditor` (the per-editor list from
  `buildOptions()`) and `augmentor_url` (absolute URL of route
  `augmentor.augmentor_execute` from `Url::fromRoute(...)`).
- `settingsForm()` lists every augmentor from `AugmentorManager::getAugmentors()` (injected service
  `plugin.manager.augmentor.augmentors`) as a checkbox; `buildOptions()` returns only the ticked
  ones as `{label, value: uuid}` pairs stored under `settings.plugins.augmentor_ckeditor`.
- `plugin.js` builds a searchable `richcombo`; `onClick(value)` reads
  `editor.getSelection().getSelectedText()` and `$.ajax` POSTs
  `{input, augmentor: value, type: 'ckeditor'}` to `augmentor_url`. On success it parses the JSON,
  splits `output.default` on `\n` and appends each non-empty line as a `<p>…</p>` via
  `editor.setData()`; on error it shows a `Drupal.Message`.
- `isEnabled()` is empty (button available whenever the plugin is enabled on the format). Access to
  the actual augmentor run is enforced server-side by the parent's `execute augmentor` permission.

## Enable

```bash
drush en augmentor_ckeditor4 -y
```
Then add the **Augmentors** button to a CKEditor 4 text-format toolbar and tick the augmentors to
expose in the button's settings. See [plugins/ckeditor-button.md](plugins/ckeditor-button.md).
