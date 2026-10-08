# Media Name — configuration & behaviour

## Config — `media_name.settings`
| Key | Type | Default | Effect |
|---|---|---|---|
| `file_name_override` | boolean | `FALSE` | When `TRUE`, restores core behaviour: on file replacement the media name is updated to the new file name — **but only** if the media name still equals the original file name and was not manually edited in the same save. |

Settings form: route `media_name.settings_form` →
`/admin/config/media/media-name/settings` (`SettingsForm`, requires `administer media`,
`_admin_route`). Single "File name override" checkbox.
```
ddev drush config:set media_name.settings file_name_override 1 -y
```

## Prerequisite
The module only acts when the *Name* field is **visible** on the media form
(`$form['name']['#access']`). Expose it per bundle at
`/admin/structure/media/manage/<type>/form-display`.

## Behaviour (service `MediaName`)
- **Field required off:** `media.name` is set non-required for the `media` entity type and per
  bundle (two hooks, because some bundles are only covered by the bundle-level hook).
- **On form build** (`alterMediaEditForm`): for existing media, records
  `MEDIA_NAME_ORIGINAL_VALUE` (current label) and `FILE_NAME_ORIGINAL_VALUE` (current file's
  filename) into the form build info; new media is skipped (core default is fine there).
- **On submit** (`mediaEditFormSubmitHandler`, added only when an original name was recorded):
  - Skips if the file name did **not** change (`$fileName === $fileNameOriginal`).
  - Optionally skips (leaving the new file name) when `file_name_override` is on **and** the
    original media name equalled the original file name **and** the name wasn't edited.
  - Otherwise `setName()` back to the submitted/custom media name and `save()`.
- File lookup: `getMediaFile()` scans the bundle's field definitions for a non-empty `file` or
  `image` field and takes the first referenced file. Filename comparison (not fid) is used so it
  cooperates with Media Entity File Replace.
