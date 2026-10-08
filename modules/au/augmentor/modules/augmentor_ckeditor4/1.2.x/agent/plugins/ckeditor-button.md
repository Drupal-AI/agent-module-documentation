<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The CKEditor 4 "Augmentors" button

## Install & enable

```bash
drush en augmentor_ckeditor4 -y
```

Dependencies: core **`ckeditor`** and the parent **`augmentor`** module. No sub-modules,
permissions, Drush commands or config schema of its own. This submodule is **deprecated** — prefer
`augmentor_ckeditor5` on CKEditor 5 sites.

## Add the button to a text format

1. Configure augmentors first in the parent module at **`/admin/config/augmentors`**
   (needs `administer augmentor`).
2. Go to **Configuration → Content authoring → Text formats and editors**, edit a format that uses
   **CKEditor** (CKEditor 4), and drag the **Augmentors** button into the *Active toolbar*.
3. Click the button's gear / open the plugin settings (the "Augmentor" settings vertical tab) and
   tick which augmentors should appear in the dropdown. Save the format.

Enabled augmentors are stored on the editor entity under
`settings.plugins.augmentor_ckeditor[<uuid>]` (a checkbox per augmentor UUID).

## The plugin class (`AugmentorCKEditor.php`)

Plugin id **`augmentor_ckeditor`**, label *"Augmentor"*, annotation `module = "augmentor"`.
Extends `CKEditorPluginBase`; implements `CKEditorPluginConfigurableInterface` and
`ContainerFactoryPluginInterface`. It injects `AugmentorManager` from the container service
`plugin.manager.augmentor.augmentors`.

| Method | What it does |
|---|---|
| `getFile()` | Returns the plugin JS path `…/js/plugins/augmentor_ckeditor/plugin.js`. |
| `getLibraries()` | Attaches library `augmentor_ckeditor4/augmentor_ckeditor` (theme CSS). |
| `getButtons()` | Declares one toolbar button `augmentor_ckeditor` (label *"Augmentors"*) with an inline-template dropdown `image_alternative`. |
| `getConfig()` | Adds JS settings `augmentor_ckeditor` = `buildOptions($editor)` and `augmentor_url` = absolute URL of route `augmentor.augmentor_execute`. |
| `settingsForm()` | One checkbox per `AugmentorManager::getAugmentors()`, default from existing editor settings. |
| `buildOptions()` | Returns only the ticked augmentors as `[{label, value: <uuid>}]`. |
| `isEnabled()` | Empty (no per-editor enable gate). |

## Runtime flow (`plugin.js`)

`CKEDITOR.plugins.add('augmentor_ckeditor', { requires: ['richcombo'], … })`:

- Builds a `richCombo` labelled *"Augmentors"* (`multiSelect: true`) populated from
  `config.augmentor_ckeditor`. A small `<input class="cke_search">` plus a jQuery `:icontains`
  filter provides type-to-filter search over the option list.
- `onClick(value)`:
  1. shows `Drupal.theme.ajaxProgressIndicatorFullscreen()`;
  2. `input = editor.getSelection().getSelectedText()`;
  3. `$.ajax` **POST** to `config.augmentor_url` with body
     `JSON.stringify({input, augmentor: value, type: 'ckeditor'})`, `dataType: 'json'`;
  4. **success:** `output = JSON.parse(result).default.toString()`, split on `\n`, and each
     non-empty line is appended as `'<p>' + line + '</p>'` to `editor.getData()`, then
     `editor.setData(newData)`;
  5. **error:** parses `result.responseJSON` and shows it via `new Drupal.Message()`.

`config.augmentor_url` resolves to the **parent** route `augmentor.augmentor_execute`
(`\Drupal\augmentor\Controller\AugmentorController::execute`, path `/augmentor/execute/augmentor`),
whose route requirement is `_permission: 'execute augmentor'`. A user without that permission
receives a 403 from the endpoint, so the button cannot run an augmentor for unauthorised users even
though the button itself is not permission-hidden in CKEditor 4. All provider/API-key handling,
input dispatch and output formatting happen in that parent controller — this submodule only sends
the selection and renders the returned text.

## Notes

- Output is appended (never replaces the selection); repeated clicks keep adding paragraphs.
- The augmentor list in both the settings form and the toolbar comes from the same
  `AugmentorManager::getAugmentors()`, so any augmentor added/removed in the parent UI is reflected
  here after a cache clear.
- Deprecated module: migrate the format to CKEditor 5 and use `augmentor_ckeditor5`, which hides its
  toolbar plugin entirely from users lacking `execute augmentor`.
