# Configuration

Media File Delete has a small settings form plus two permissions that together
control who can delete files and how the checkbox behaves.

## Settings form

Go to **Configuration → Media → Media File Delete Settings**
(`/admin/config/media/media_file_delete/settings`), gated by the **Administer media
file delete** permission. It writes to the `media_file_delete.settings` config
object (which exports and deploys like any other config). There are two options:

- **Delete file by default** (`delete_file_default`, *off by default*) — the
  starting state of the "Also delete the associated file?" checkbox on the media
  delete forms. Turn it on if you want editors to delete files by default and
  opt *out* per deletion.
- **Disable delete control** (`disable_delete_control`, *off by default*) — when on,
  the checkbox is hidden from editors entirely and the **Delete file by default**
  value is applied silently on every delete. Use this to enforce a fixed site
  policy (either always delete files, or never) with no per‑delete choice.

You can also set these from the command line:

```bash
drush cset media_file_delete.settings delete_file_default true
```

## When the checkbox appears

Even with the setting on, the checkbox only shows when the file is actually safe to
delete. On the single delete form the module checks that:

1. The media source is **file‑based** (image, document, audio, or video) — other
   source types have no file to delete.
2. The current user has **delete access** to that file. If the file is owned by
   someone else and the user can't delete it, the form shows a message that the
   file will be retained — no checkbox.
3. The file's **usage count is not greater than 1**. If it is used elsewhere, the
   form says so and retains the file — no checkbox.

Only when all three pass does the checkbox appear. The bulk delete form applies the
same checks per item and reports how many files were deleted, skipped for
insufficient privilege, or skipped because they are still in use.

## Permissions

| Permission | What it allows |
|-----------|----------------|
| **Administer media file delete** | Access the settings form and change the two options above. |
| **Delete any file** | Delete a source file even when the user is *not* its owner. This is security‑sensitive (restricted) — grant it only to trusted roles. Without it, files owned by other users are retained and the form shows a message instead of the checkbox. |

Note there is no separate permission for the checkbox itself; whether editors see
it is governed by the **Disable delete control** setting, not a permission.

```bash
drush role:perm:add editor 'delete any file'
```
