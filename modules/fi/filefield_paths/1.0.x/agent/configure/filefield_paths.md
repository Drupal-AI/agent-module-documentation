# Configure File (Field) Paths

Configuration lives in **two places**: a per-field settings section on every File/Image
field, and one global settings form for the default temporary location.

## Per-field settings (the main config)

Added by `hook_form_field_config_edit_form_alter` to any field whose item class is
`FileFieldItemList` or a subclass (core File, Image, and other file-based fields). Edit at:

`Structure → Content types → {type} → Manage fields → {file/image field} → Field settings`
(e.g. `/admin/structure/types/manage/article/fields/…`).

Turn on **Enable File (Field) Paths?** to reveal the "File (Field) Path settings" details. It
adds these fields (contributed by `hook_filefield_paths_field_settings`; core supplies
**File path** and **File name**):

| Setting | Purpose |
|---|---|
| **File path** (`file_path.value`) | Token pattern for the destination directory, e.g. `articles/[node:nid]`. |
| **File name** (`file_name.value`) | Token pattern for the stored filename, e.g. `[node:nid]-[file:name]`. |
| **File path/name options** | Per-pattern cleanup, see below. |
| **Temporary file location** (`temp_location`) | Per-field temp scheme where uploads land before processing; blank = global default. |
| **Create Redirect** (`redirect`) | Create a redirect from a file's old URL when it moves. Disabled unless the Redirect module is enabled. |
| **Retroactive update** (`retroactive_update`) | On save, batch-move/rename **all** existing files of the bundle once, then re-disables. Warning: dev/careful use only. |
| **Active updating** (`active_updating`) | Re-move/rename files each time their parent entity is saved. Warning: dev/careful use only. |

Cleanup **options** available on both File path and File name:

| Option key | Effect |
|---|---|
| `slashes` | Remove slashes (`/`) from token values (so a token can't spawn subfolders). |
| `pathauto` | Clean the string with Pathauto's alias cleaner. Disabled unless the Pathauto module is enabled. |
| `transliterate` | One-way transliteration (romanization) to safe US-ASCII on upload. |

Tokens: when the Token module is present, patterns are validated and a token-tree browser is
shown; usable token types include `file`, `date`, and the field's own entity type.

**How files actually move:** because full token values aren't known during upload, files are
saved to the temporary location first (`hook_file_presave`), then moved to the token-built
path when the entity is inserted/updated (`hook_entity_insert` / `hook_entity_update`).

### Storage (third-party settings)

All per-field values are stored as field-config third-party settings under
`field.field.*.*.*.third_party.filefield_paths` (schema in
`config/schema/filefield_paths.schema.yml`): `enabled`, `file_path` / `file_name` (each with
`value` + `options.{slashes,pathauto,transliterate}`), `temp_location`, `redirect`,
`retroactive_update`, `active_updating`. They export/deploy with the field config, so set them
per environment via `drush config:export`/`import`.

## Global settings form — `filefield_paths.admin_settings`

Route path `/admin/config/media/file-system/filefield-paths`, permission
`administer site configuration`. Form class `Drupal\filefield_paths\Form\SettingsForm`.
It sets the config object `filefield_paths.settings`:

| Key | Default | Meaning |
|---|---|---|
| `temp_location` | `public://filefield_paths` | Default temporary upload location used when a field leaves its own temp location blank. |

Set via drush: `drush cset filefield_paths.settings temp_location 'temporary://filefield_paths'`.
The form recommends `temporary://` (or `private://` when file previews are needed) and warns
against `public://` on sites that support private files.
