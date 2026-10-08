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
  `/admin/structure/path_file_entity/settings` (route `path_file_entity.settings`). On submit the
  form saves the config **and** calls
  `EntityDefinitionUpdateManager::updateFieldStorageDefinition()` for the `fid` field so the new
  extension list takes effect.

Set it with drush:

```bash
drush cset path_file.settings allowed_extensions 'pdf svg webp' -y
drush cget path_file.settings allowed_extensions
```

## Admin routes

| Route | Path | Purpose |
|---|---|---|
| `entity.path_file_entity.collection` | `/admin/structure/path_file_entity` | List of Path Files (the module's `configure` route). Also linked under *Content* (`system.admin_content`). |
| `entity.path_file_entity.add_form` | `/admin/structure/path_file_entity/add` | Create a Path File. |
| `path_file_entity.settings` | `/admin/structure/path_file_entity/settings` | Allowed-extensions form. |
| `entity.path_file_entity.canonical` | `/path-file/{path_file_entity}` | Streams the file. |

## Config schema

`path_file.settings` is declared in `config/schema/path_file.schema.yml` (label + `allowed_extensions`
string), so `drush cset` validates it. There are no per-entity config entities — Path Files are
**content** entities in the `path_file_entity` base table.
