# Configuration

Simple Media Bulk Upload has just one setting of its own, plus a couple of
permissions that decide who can use it. Most of what governs an upload — allowed
file extensions and maximum size — actually comes from the media type you upload
into, not from this module.

## The settings form

1. Log in as a user with the **Administer simple media bulk upload** permission.
2. Go to **Configuration → Media → Simple Media Bulk Upload**, or directly to
   `/admin/config/media/simple-media-bulk-upload`.

The form has a single field:

- **Maximum number of files** *(default 30)* — the most files a user may drop onto
  the widget in one upload. Set it to **0** for no limit. When the value is above
  zero, the upload form displays a hint such as "Up to 30 files can be uploaded at
  once."

Click **Save configuration** to apply.

## What controls extensions and file size

The bulk upload form does **not** define its own allowed extensions or size cap.
Those are read from the source field of whichever media type you choose on the
form. So if your Image media type allows `png jpg gif` up to 8 MB, the bulk form
enforces exactly that. Adjust the media type's field settings (under **Structure →
Media types**) if you need to change what can be uploaded.

## Permissions

Two permissions matter, and they do different jobs:

| Permission | Defined by | Controls |
|---|---|---|
| `dropzone upload files` | DropzoneJS (dependency) | Access to the bulk upload form itself |
| `administer simple media bulk upload` | this module | Access to the settings form above |

A few things to keep in mind:

- The upload form is gated by **`dropzone upload files`**, not by a module‑specific
  "upload media" permission. Grant it to any role that should bulk upload.
- Even with that permission, uploads still respect **media access**: the form only
  lists media types the user has permission to *create*, so your per‑type create
  permissions continue to apply.
- **`administer simple media bulk upload`** only unlocks the max‑files settings
  form — it does not grant upload rights.

You can grant these from the command line, for example:

```bash
drush role:perm:add editor 'dropzone upload files'
```
