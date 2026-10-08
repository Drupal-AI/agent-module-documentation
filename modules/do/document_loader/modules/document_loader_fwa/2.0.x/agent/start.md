<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document Loader: Field Widget Actions (document_loader_fwa) — agent index

A **Field Widget Actions** button that extracts a source field's document via **Document Loader**
and AJAX-fills a destination field. Package `Web services`. Version 2.0.5. Core `^10.4 || ^11`.
GPL-2.0-or-later. Depends on `document_loader` + `field_widget_actions`. No permissions, routes, or
Drush of its own.

## What it provides

- **One plugin**: `src/Plugin/FieldWidgetAction/DocumentLoaderAction.php`, id
  **`document_loader_fwa`**, label "Load Document", category "Document Loader". Extends
  `FieldWidgetActionBase`, uses `InputResolverTrait`. `multiple: TRUE`.
  - Attach widget types: `string_textfield`, `string_textarea`, `text_textfield`,
    `text_textarea`, `text_textarea_with_summary`, `file_generic`, `image_image`,
    `media_library_widget`, `link_default`.
  - Destination field types: `text_long`, `text_with_summary`, `json`, `json_native`,
    `json_native_binary` (must be on the same form display; the source field is excluded).
- **Config schema** (`config/schema/document_loader_fwa.schema.yml`): extends
  `field_widget_action_plugin_base` with `destination_field` (string), `output_format` (string),
  `loader_settings` (`ignore` — holds `dl__{loader_id}__{option_key}` values).

## Mechanism (from source)

- `loadDocument()` reads the source value, resolves it via `resolveInputData()`
  (file/image → `file_input`; media → file URI or URL; link/text → `url` or `file_input`), merges
  per-loader options (`extractLoaderOptionsFromArray()`), and calls
  `DocumentLoaderManager::loadFromData($data, currentUser, $outputFormat, caller: 'fwa')`.
- JSON destinations force `output_format = 'json'`; valid JSON content is wrapped as
  `{"content": …}`.
- Fills via `FillEditorCommand` (text_long / text_with_summary) or `FillSimpleFieldCommand`
  (JSON), using a global `[name="{field}[0][value]"]` selector.
- The AJAX callback is **static** (`ajaxCallback()` re-instantiates from the container) with no
  wrapper and `suppressSave` submit — deliberately avoiding form-cache serialization of the
  file widget's `UploadedFile`.

## Operate

1. `drush en document_loader_fwa -y` (a loader plugin module must be installed to extract).
2. *Structure → Content types → [type] → Manage form display*, gear on the source widget → add
   **Load Document** (Document Loader category) → set destination field + output format.
3. On the edit form, provide the source (upload / URL) and click **Load Document**.

## Notes

- Runs as the current user; source file entity `view` access is enforced by the pipeline.
- Without a loader plugin, the button reports "No document loader plugin is available".
