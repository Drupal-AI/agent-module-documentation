# Configure Media Library Importer

Config form: `\Drupal\media_library_importer\Form\ConfigurationForm` at
`/admin/config/media/media-library-importer` (route `media_library_importer.configuration`, permission
**"Configure media library importer"**). Config object `media_library_importer.settings`.

## Config keys (config/install defaults)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `import_folder` | string | `''` (form shows public files realpath) | Absolute filesystem path to scan for files to import. |
| `exclude_styles` | bool | `true` | Skip the image-`styles/` derivative folder while scanning. |
| `import_files_to_media_location` | bool | `true` | If TRUE, copy each source file into the target media type's destination directory (creates a managed copy); if FALSE, register the file in place at its existing path. |
| `media_types_import` | sequence | `{}` | Machine names of media types to import (checkboxes; AJAX-populates the field mapping). |
| `media_types_fields` | sequence | `{}` | Per media type, the machine name of the field that stores the file. |

- The form defaults the `import_folder` textfield to the public files real path and instructs prefixing paths with
  it.
- Selecting media types AJAX-renders one select per type to choose its file field (only `FieldConfig` fields listed).

## Routes / tasks

| Route | Path | Permission |
|---|---|---|
| `media_library_importer.configuration` | `/admin/config/media/media-library-importer` | Configure media library importer |
| `media_library_importer.import` | `/admin/config/media/media-library-importer/import` | Import files into media library |

## Import screen

`\Drupal\media_library_importer\Form\ImportForm` (route `.import`) renders a checkbox tree of folders (from
`getMediaFolders()`/`getMediaFoldersCheckboxOptions()`) under `import_folder`, all checked by default. Submit calls
`generateImportQueue($selected_folders)` then `processImportQueue()` (batch). Extensions accepted per folder are the
union of the selected media types' source-field `file_extensions`.

## Drush / config

```bash
ddev drush config:set media_library_importer.settings import_folder /var/www/html/web/sites/default/files/incoming -y
ddev drush cget media_library_importer.settings
ddev drush media-library:import   # or: ddev drush mli
```
