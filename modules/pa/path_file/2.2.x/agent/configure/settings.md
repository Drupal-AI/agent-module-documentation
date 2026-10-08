# Configure Path File

## Allowed file extensions (the only setting)

Config object: **`path_file.settings`**, one key:

```yaml
allowed_extensions: 'pdf jpg jpeg gif png txt doc xls pdf ppt pps odt ods odp'  # shipped default
```

- Space-separated list of extensions (same format as a core file field's `file_extensions`).
- Drives the `fid` file field's `file_extensions` setting — `PathFileEntity::baseFieldDefinitions()`
  reads `\Drupal::config('path_file.settings')->get('allowed_extensions')`.
- Edited via the settings form `PathFileEntitySettingsForm` at
  `/admin/content/path_file/settings` (route `path_file_entity.settings`). On submit the
  form saves the config **and** calls
  `EntityDefinitionUpdateManager::updateFieldStorageDefinition()` for the `fid` field so the new
  extension list takes effect.
- The form **validates input**: `validateForm()` rejects anything that is not
  letters, numbers, and spaces (`/^[a-zA-Z0-9\s]+$/`), so the leading dot / commas are not allowed.

Set it with drush:

```bash
drush cset path_file.settings allowed_extensions 'pdf svg webp' -y
drush cget path_file.settings allowed_extensions
```

## Admin routes

| Route | Path | Purpose |
|---|---|---|
| `entity.path_file_entity.collection` | `/admin/content/path_file` | List of Path Files (the module's `configure` route). Linked under *Content* (`system.admin_content`). Requires `access path file entity overview`. |
| `entity.path_file_entity.add_form` | `/admin/content/path_file/add` | Create a Path File. |
| `path_file_entity.settings` | `/admin/content/path_file/settings` | Allowed-extensions form. Requires `administer path file entity entities`. |
| `entity.path_file_entity.canonical` | `/path-file/{path_file_entity}` | Streams the file (`_entity_access: path_file_entity.view`). |

> The admin UI moved from `/admin/structure/path_file_entity` (2.1.x) to `/admin/content/path_file`
> in 2.2.x; the menu link now sits under **Content**.

## Config schema

`path_file.settings` is declared in `config/schema/path_file.schema.yml` (label + `allowed_extensions`
string), so `drush cset` validates it. There are no per-entity config entities — Path Files are
**content** entities in the `path_file_entity` base table.
