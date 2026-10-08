# Configure & how the delete option works

## Settings — `media_file_delete.settings`

Form at `/admin/config/media/media_file_delete/settings` (route `media_file_delete.settings`,
`MediaDeleteSettingsForm`), or via `drush cset`. Defaults from `config/install`:

| Key | Default | Meaning |
|---|---|---|
| `delete_file_default` | `false` | Default state of the "Also delete the associated file?" checkbox on the media delete forms |
| `disable_delete_control` | `false` | If `true`, hide the checkbox from editors; the `delete_file_default` value is applied silently (no per-delete choice) |

Config schema: `config/schema/media_file_delete.schema.yml` (both keys `boolean`). It is a
`config_object`, so it exports/deploys with `drush config:export`. Example:
`drush cset media_file_delete.settings delete_file_default true`.

## How the confirm option hooks the media delete flow

`MediaFileDeleteHooks::entityTypeAlter()` (`hook_entity_type_alter`) swaps the `media` entity's
form classes:

- `delete` handler → `MediaDeleteForm` (extends core `ContentEntityDeleteForm`)
- `delete-multiple-confirm` handler → `MediaDeleteMultipleForm` (extends core `DeleteMultipleForm`)

It also sets the `file` entity's access handler to `MediaFileDeleteFileAccessControlHandler`
(see permissions doc).

Single delete (`MediaDeleteForm`):

1. `buildForm()` finds the media's source file — only when the source field's item class is a
   `FileItem` (image/document/audio/video sources); otherwise no checkbox is added.
2. If the current user lacks `delete` access on that file, a message says the file is owned by
   someone else and will be retained — no checkbox.
3. If the file's usage count (chained resolver) is `> 1`, a message says it is used elsewhere
   and will be retained — no checkbox.
4. Otherwise it appends an `also_delete_file` checkbox, default = `delete_file_default`,
   `#access = !disable_delete_control`.
5. `submitForm()` deletes the media (parent), then if `also_delete_file` is set, calls
   `$file->delete()` and shows "Deleted the associated file %name."

Bulk delete (`MediaDeleteMultipleForm`) adds the same checkbox, then in `submitForm()` iterates
the selected media and for each only deletes the file when: the actor has media `delete` access,
has file `delete` access (else counted as insufficient-privilege), and usage is `0` (else counted
as in-use). It reports status/warning counts and logs deletions to the `media_file_delete`
logger channel.
