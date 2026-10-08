<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The ckeditor5_template CKEditor 5 plugin

The module contributes **one** CKEditor 5 plugin. It does not define any Drupal plugin
*type* of its own — it plugs into core's CKEditor 5 plugin system.

## Definition (`ckeditor5_template.ckeditor5.yml`)

```yaml
ckeditor5_template_template:          # Drupal CKEditor 5 plugin id
  ckeditor5:
    plugins:
      - template.Template             # the JavaScript plugin (js/ckeditor5_plugins/template)
  drupal:
    label: Template
    class: \Drupal\ckeditor5_template\Plugin\CKEditor5Plugin\Template
    library: ckeditor5_template/template
    admin_library: ckeditor5_template/admin
    toolbar_items:
      template:                       # <-- toolbar item id (what you drag onto the toolbar)
        label: Template
    elements: false                   # plugin adds no new allowed HTML tags of its own
```

Key ids to remember:
- **Drupal plugin id:** `ckeditor5_template_template` (the key under `settings.plugins`).
- **JS plugin:** `template.Template`.
- **Toolbar item:** `template`.

## PHP class

`src/Plugin/CKEditor5Plugin/Template.php` extends `CKEditor5PluginDefault` and implements
`CKEditor5PluginConfigurableInterface` (via `CKEditor5PluginConfigurableTrait`):

- `buildConfigurationForm()` — the three settings fields (`file_path`, `show_toolbar_text`,
  `custom_toolbar_text`).
- `validateConfigurationForm()` — errors if `!file_exists(DRUPAL_ROOT . file_path)`.
- `getDynamicPluginConfig()` — injects `file_path` (prefixed with the request base path),
  `show_toolbar_text`, and `custom_toolbar_text` into the front-end plugin config at render.
- `defaultConfiguration()` — `file_path` = bundled example, `custom_toolbar_text` =
  `Template`, `show_toolbar_text` = `1`.

## Config schema (`config/schema/ckeditor5_template.schema.yml`)

```yaml
ckeditor5.plugin.ckeditor5_template_template:
  type: mapping
  mapping:
    file_path: { type: string }            # path to the JSON templates file
    custom_toolbar_text: { type: string }  # label next to the icon
    show_toolbar_text: { type: integer }   # 0 / 1
```

## Template JSON file shape

`file_path` points at a JSON **array**; each object is one template offered in the picker:

```json
[
  {
    "title": "Simple Table",
    "icon": "<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"24\" height=\"24\" viewBox=\"0 0 24 24\"><path d=\"M8 16h8v2H8z\"/></svg>",
    "description": "Insert a simple Table.",
    "html": "<table border='1'><tr><th>Header 1</th><th>Header 2</th></tr><tr><td>a</td><td>b</td></tr></table>"
  }
]
```

- `title` — name shown in the picker.
- `icon` — inline SVG markup shown for the entry.
- `description` — short help text under the title.
- `html` — the markup inserted at the cursor when the template is chosen. (It must be allowed
  by the format's filters/allowed tags to survive; the plugin itself declares `elements: false`.)

The bundled example (`template/ckeditor5_template.json.example`) defines two templates: a
"Link" snippet and a "Simple Table".

## Providing your own templates

Copy the example to a path under your codebase or a custom module, edit the array, and set the
format's `file_path` to that path (leading `/`, relative to the Drupal root). No code changes
are needed — configuration is per text format (see
[../configure/ckeditor5_template.md](../configure/ckeditor5_template.md)).
