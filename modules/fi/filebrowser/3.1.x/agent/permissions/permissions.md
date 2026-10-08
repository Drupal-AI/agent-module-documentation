# Permissions

Provided by `Drupal\filebrowser\FilebrowserPermissions::permissions()` (a
`permission_callbacks` entry in `filebrowser.permissions.yml`). Machine names are defined as
constants on `Drupal\filebrowser\Services\Common`. There is **no permission set by default** —
you must grant them per role.

| Machine name | Constant | Gates |
|---|---|---|
| `create listings` | `CREATE_LISTING` | Create a `dir_listing` node |
| `delete listings` | `DELETE_OWN_LISTINGS` | Delete a listing you own |
| `delete any listings` | `DELETE_ANY_LISTINGS` | Delete any listing |
| `edit own listings` | `EDIT_OWN_LISTINGS` | Edit a listing you own |
| `edit any listings` | `EDIT_ANY_LISTINGS` | Edit any listing |
| `view listings` | `VIEW_LISTINGS` | View listings |
| `upload files` | `FILE_UPLOAD` | Upload files (node must also allow uploads) |
| `create folders` | `CREATE_FOLDER` | Create sub-directories |
| `download archive` | `DOWNLOAD_ARCHIVE` | Download folder as a zip (node must allow it) |
| `download files` | `DOWNLOAD` | Download individual files |
| `delete files` | `DELETE_FILES` | Delete files |
| `rename files` | `RENAME_FILES` | Rename files (folders cannot be renamed) |
| `edit description` | `EDIT_DESCRIPTION` | Edit file descriptions |

Several action routes also enforce these directly (e.g. `filebrowser.page_download` requires
`download files`, `filebrowser.inline_description_form` requires `rename files`).

Filebrowser also declares standard entity permissions for its **metadata entity** config type
(`add/administer/delete/edit/view published/view unpublished filebrowser metadata entity
entities`) — these gate the `filebrowser_metadata_entity` admin, not the file listings.

## Grant with drush

```bash
drush role:perm:add anonymous 'view listings,download files'
drush role:perm:add authenticated 'upload files,download archive'
```

Note that upload/archive permissions only take effect when the individual listing's node
settings (`uploads.enabled`, `rights.download_archive`) also allow the action.
