<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Augmentor (augmentor_ckeditor5) — agent index

Submodule of **augmentor**. Adds an **"Augmentors" toolbar dropdown** to **CKEditor 5** that runs a
configured augmentor on the selected text and inserts the result at the cursor. Package `Augmentor`.
Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.2.x. Depends on core **`ckeditor5`**
and **`augmentor`**. This is the current editor integration (replaces the deprecated
`augmentor_ckeditor4`).

- **The CKEditor 5 plugin, its settings form, config schema, permission gating and request flow** →
  [plugins/ckeditor5-plugin.md](plugins/ckeditor5-plugin.md)

## What it actually is

- One CKEditor 5 plugin, declared in `augmentor_ckeditor5.ckeditor5.yml` as
  **`augmentor_ckeditor5_augmentor`** (toolbar item `augmentor`, label *"Augmentors"*), backed by
  PHP class `src/Plugin/CKEditor5Plugin/Augmentor.php` and JS plugin `augmentor.augmentor`
  (`js/build/augmentor.js`; sources in `js/ckeditor5_plugins/augmentor/src/`).
- Config schema `config/schema/augmentor_ckeditor5.schema.yml`
  (`ckeditor5.plugin.augmentor_ckeditor5_augmentor`, a `sequence` of augmentor strings under
  `augmentors`).
- A hook class `src/Hook/AugmentorCkeditor5Hooks.php` (service, autowired) implementing
  `hook_ckeditor5_plugin_info_alter()`; legacy shim in `augmentor_ckeditor5.module`.
- Libraries in `augmentor_ckeditor5.libraries.yml`: `augmentor` (the built JS, depends on
  `core/ckeditor5`) and `admin.augmentor` (theme CSS `css/augmentor.css`).
- **No routes, controller or permissions of its own.** It POSTs to the **parent** endpoint
  `/augmentor/execute/augmentor` (route `augmentor.augmentor_execute`, gated by parent permission
  **`execute augmentor`**).

## Mechanism (from source)

- **Permission gating** — `AugmentorCkeditor5Hooks::ckeditor5PluginInfoAlter()` unsets the
  `augmentor_ckeditor5_augmentor` plugin definition when the current user lacks
  `execute augmentor`, so the toolbar button is not offered to unauthorised users.
- **PHP plugin** `Augmentor` (extends `CKEditor5PluginDefault`, implements
  `CKEditor5PluginConfigurableInterface`) injects `AugmentorManager`
  (`plugin.manager.augmentor.augmentors`). `buildConfigurationForm()` renders one checkbox per
  augmentor; `submitConfigurationForm()` stores `configuration['augmentors'][<uuid>] = <label>` for
  ticked ones; `getDynamicPluginConfig()` passes the enabled augmentors to the JS as
  `augmentors: [ { augmentors: {uuid: label, …} } ]`; `cleanUpAugmentors()` drops any augmentor no
  longer resolvable via `AugmentorManager::getAugmentor()`.
- **JS** (`js/ckeditor5_plugins/augmentor/src/`): `augmentorui.js` builds the dropdown from
  `editor.config.get('augmentors')[0].augmentors` and registers command `executeCommand`
  (`execute/executecommand.js`). The command reads the selection text, `fetch`-POSTs
  `{input, augmentor: <uuid>, type: 'ckeditor'}` to `baseUrl + 'augmentor/execute/augmentor'`
  (`credentials: 'same-origin'`), then `_updateCkeditor()` inserts `output.default` (with `\n`
  → `<br/>`) at the saved selection position; `_showError()` shows a `Drupal.Message`.

## Enable

```bash
drush en augmentor_ckeditor5 -y
```
Then add the **Augmentors** button to a CKEditor 5 text-format toolbar and tick the augmentors to
expose. See [plugins/ckeditor5-plugin.md](plugins/ckeditor5-plugin.md).
