<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Type Config Export — routes, forms, modes, ZIP build

Source: `content_type_config_export.routing.yml`, `*.permissions.yml`, `*.links.task.yml`,
`*.services.yml`, `.module`, `src/Controller/*`, `src/Form/*`, `src/Hook/*`.

## Install / enable

`drush en content_type_config_export`. No composer package, no module dependencies, no config to
install. Paragraph-type export routes exist regardless, but paragraph handling degrades gracefully
when the `paragraphs` module is absent (`AbstractExportForm` checks
`entityTypeManager->hasDefinition('paragraphs_type')` before touching paragraph config). Grant the
relevant permission(s) at `/admin/people/permissions`.

## Routes and permissions

| Route | Path | Permission |
|---|---|---|
| `content_type_config_export.export` | `/admin/structure/types/manage/{node_type}/export` | `export content type configuration` |
| `block_type_config_export.export` | `/admin/structure/block-content/manage/{block_content_type}/export` | `export block type configuration` |
| `vocabulary_config_export.export` | `/admin/structure/taxonomy/manage/{taxonomy_vocabulary}/export` | `export vocabulary configuration` |
| `paragraph_type_config_export.export` | `/admin/structure/paragraphs_type/{paragraphs_type}/export` | `export paragraph type configuration` |
| `role_config_export.export` | `/admin/people/export` | `export role configuration` |

All five permissions are declared `restrict access: true` in `*.permissions.yml`. The bundle routes
are local tasks (tabs) on the bundle edit/overview form; the role route is an action on the user
collection (`*.links.task.yml`). The GET route only renders the form; the actual export is a POST of
that Drupal form (standard form-token CSRF protection applies).

## Controllers

Each controller (`src/Controller/*ExportController.php`) loads the entity from the route parameter,
throws `NotFoundHttpException` if it does not exist, and returns a container render array embedding
the matching form via `formBuilder()->getForm(...)`. `RoleExportController::export()` takes no
parameter and renders `RoleExportForm`.

## Forms and export modes

Bundle forms (`ContentTypeExportForm`, `BlockTypeExportForm`, `ParagraphTypeExportForm`,
`VocabularyExportForm`) extend `AbstractExportForm` (`src/Form/AbstractExportForm.php`), which is a
`FormBase` constructed with `entity_type.manager` and `file_system`. Each subclass supplies:

- `getEntityType()` — the field-config entity type (`node`, `block_content`, `paragraph`,
  `taxonomy_term`).
- `getExportType()` — a slug used in filenames (e.g. `content-type`, `vocabulary`).
- `getHelpSelectedText()` / `getHelpFullText()` — translated help strings.
- `exportSelected($dir, $selected_fields)` / `exportFull($dir)` — what to write.

`AbstractExportForm::buildForm()` builds a `mode` radios element with two options:

- **`selected`** ("Selected fields only") — a `checkboxes` list of the bundle's `field_config`
  fields (loaded via `field_config` storage by `entity_type` + `bundle`). Writes the bundle config
  and only the chosen field instances + their field storage. Displays are intentionally excluded.
- **`full`** ("Full …") — writes the bundle config, all field instances + storage, and both
  `core.entity_form_display.*` and `core.entity_view_display.*` objects for the bundle.

`validateForm()` errors if `selected` mode is chosen but the bundle has no custom fields.

## How config is collected and zipped (`AbstractExportForm::submitForm`)

1. `$dir = "temporary://{getExportType()}-export-{entityId}"`; any prior dir is
   `deleteRecursive()`'d, then `prepareDirectory()` recreates it. `entityId` is the validated
   bundle machine name from the route.
2. Mode dispatch calls `exportSelected()` or `exportFull()`.
3. `writeConfig($dir, $name)` reads `configFactory()->get($name)`, and if not new writes
   `Yaml::dump($config->getRawData(), 10, 2)` to `$dir/$name.yml`.
4. A `\ZipArchive` is created at `temporary://{type}-{entityId}-export.zip`; only `glob($dir/*.yml)`
   files are added (`basename` entries). Robust `\RuntimeException`s guard each ZIP step.
5. The ZIP is streamed as a `BinaryFileResponse` attachment via `$form_state->setResponse()`.

### Paragraph reference recursion

`exportReferencedParagraphTypesForField()` inspects a field's `target_type === 'paragraph'` and
`handler_settings['target_bundles']`, then `exportParagraphTypeConfig()` writes
`paragraphs.paragraphs_type.*`, its `field.field.paragraph.*` + storage, and its form/view displays
— recursing into nested paragraph references and de-duplicating via an `$exported_paragraph_types`
map.

### Role export (`RoleExportForm`)

Standalone `FormBase`. `submitForm()` loads all `user_role` entities, writes each `user.role.<id>`
config as `<dir>/user.role.<id>.yml` (raw data), zips them to `temporary://role-export.zip`, and
streams it as `role-export.zip`.

## Entity operation

`ContentTypeConfigExportHooks::entityOperationAlter()` (`#[Hook('entity_operation_alter')]`, also
exposed through the `#[LegacyHook]` wrapper in the `.module`) adds an "Export" operation (weight 100)
to `node_type`, `block_content_type`, `taxonomy_vocabulary` and `paragraphs_type` list rows — each
only when `currentUser->hasPermission(...)` for the matching export permission is true.
