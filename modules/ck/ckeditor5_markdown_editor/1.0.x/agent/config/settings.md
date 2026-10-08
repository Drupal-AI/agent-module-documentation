<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling Markdown output per text format

## Install & enable

1. `drush en ckeditor5_markdown_editor` (dependency: core `ckeditor5`).
2. Fetch the JS plugin assets once: `drush ckeditor5_markdown_editor:install` (see [../commands/drush.md](../commands/drush.md)). Without the files present, `hook_ckeditor5_plugin_info_alter()` removes the plugin and logs an error, and the status report (`hook_requirements()`) shows "Missing plugins".
3. Edit a text format/editor at `admin/config/content/formats/manage/<format>` (the format must use the **CKEditor 5** editor).

## The "Markdown output" checkbox

The CKEditor 5 plugin `ckeditor5_markdown_editor_markdown_gfm` is declared in `ckeditor5_markdown_editor.ckeditor5.yml`:

- `ckeditor5.plugins: [ markdownGfm.Markdown ]` — the JS data processor loaded into the editor.
- `drupal.library: ckeditor5_markdown_editor/markdown-gfm`, `drupal.elements: false` (adds no HTML tags to the format's allowed-tags).
- `drupal.conditions.requiresConfiguration: { markdown_output: true }` — the plugin is only active when the checkbox is on.
- `drupal.class: Drupal\ckeditor5_markdown_editor\Plugin\CKEditor5Plugin\MarkdownOutputSettings` — the config UI + storage.

`MarkdownOutputSettings` (`src/Plugin/CKEditor5Plugin/MarkdownOutputSettings.php`) extends `CKEditor5PluginDefault` with `CKEditor5PluginConfigurableTrait`:

- `defaultConfiguration()` → `['markdown_output' => false]`.
- `buildConfigurationForm()` → single `#type => checkbox` "Markdown output in the CKEditor5 instance".
- `submitConfigurationForm()` → saves `markdown_output` into `$this->configuration`.
- `getDynamicPluginConfig()` → passes `ckeditor5_markdown_editor_markdown_gfm => <bool>` to the JS layer.

When checked, CKEditor's data pipeline stores **Markdown source** in the field instead of HTML. Conversion runs in the browser; there is no server-side render route in this module.

### Where the setting lives

Stored on the **editor** config entity, not in this module's own config, e.g.:

```
editor.editor.<format>:
  settings:
    plugins:
      ckeditor5_markdown_editor_markdown_gfm:
        markdown_output: true
```

Schema for this per-editor value: `ckeditor5.plugin.ckeditor5_markdown_editor_markdown_gfm` in `config/schema/ckeditor5_markdown_editor.schema.yml` (`markdown_output: boolean`).

`hook_library_info_alter()` in `.module` scans all `editor.editor.*` configs; if any has `settings.plugins.ckeditor5_markdown_editor_markdown_gfm.markdown_output = true`, it attaches `ckeditor5_markdown_editor/markdown_plugin` as a dependency of core's `internal.drupal.ckeditor5` library.

## Module config object

`ckeditor5_markdown_editor.settings` (default `config/install/ckeditor5_markdown_editor.settings.yml`, both empty strings):

- `ckeditor_version` — override the detected core CKEditor version used for asset lookups. When empty, `AssetManager::getCKEditorVersion()` parses `core/core.libraries.yml`, falling back to `4.5.x`.
- `plugins_version_installed` — set by the install command to record which plugin build is on disk (drives the "Mixed versions" status-report warning).

There is **no admin settings form / configure route** (`data.json` `configure: null`); these values are edited via config import or Drush, and `plugins_version_installed` is written automatically by the install command.

## Rendering the stored Markdown

This module only changes what the editor *stores*. To display it as HTML, add a Markdown text filter (`drupal/markdown_easy`) to the format, or use a Markdown field formatter (`drupal/markdown_field_formatter`) on the display. The text-format filter pipeline remains the output/sanitization boundary.
