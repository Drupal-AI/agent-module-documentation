<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Choosing the spec — settings form

Source: `src/Form/SwaggerUiSettingsForm.php` (form id `swagger_ui_settings_form`), route
`swagger_ui_info.admin_settings` at **`/admin/config/services/swagger_ui_info`**, permission
**`administer swagger ui settings`** (`restrict access: TRUE`). Menu link
`swagger_ui_info.admin_settings` places it under Configuration → Web services
(`system.admin_config_services`).

![Swagger UI info settings form](../../../../../../../screenshots/swagger_ui_info/2.0.x/settings-form.png)

## Install / enable

```
composer require drupal/swagger_ui_info   # pulls drupal/swagger_ui_formatter ^4.4
drush en swagger_ui_info -y
```

`swagger_ui_formatter` must be present and its bundled Swagger UI JS library correctly installed;
this module reuses that library (see [../api/display.md](../api/display.md)).

## The two ways to set the spec

`buildForm()` renders two fields; you use one or the other:

- **`file_json`** — a core `#type => 'managed_file'`. Restricted to the `json` extension
  (`#upload_validators => ['file_validate_extensions' => ['json']]`), uploaded to
  `public://swagger_files`. Its `#default_value` is the currently stored file id
  (State key `swagger_ui_file`).
- **`file_json_path`** — a `#type => 'textfield'`, "File path": an absolute path or URL to an
  existing JSON file. Its `#description` shows the module's bundled example path from
  `exampleSwagger()` → `accets/swagger/swagger_cart_example.json`. Its `#default_value` is the
  stored path only when no managed file is set.

`validateForm()` is empty — there is no server-side validation of the entered path.

## What "Save" stores (State API, not config)

`submitForm()` writes to Drupal **State** (`\Drupal::state()`), so the selection is **not**
exportable configuration and there is no `config/schema` in this version:

- If a managed file was uploaded: it loads the `File` entity, resolves its stream-wrapper
  `realpath()` and checks `file_exists()`, then sets State `swagger_ui_file` = the file id and
  State `swagger_ui_file_path` = `fileUrlGenerator->generateAbsoluteString($uri)` (an absolute
  URL to the public file).
- Else if only the text path is filled: it sets State `swagger_ui_file` = `NULL` and State
  `swagger_ui_file_path` = the entered string verbatim.

The display page reads `swagger_ui_file_path` at render time. Re-save to swap the spec. To reset
via CLI: `drush state:delete swagger_ui_file` and `drush state:delete swagger_ui_file_path`
(or `drush state:set swagger_ui_file_path '<url>'`).

## Services injected

`create()` injects `state`, `module_handler`, `entity_type.manager`, `stream_wrapper_manager`,
`file_url_generator`.
