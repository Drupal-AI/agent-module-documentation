# Configuration

Setting up Media Bulk Upload is three steps: create a **bulk‑upload
configuration**, grant its **permission** to the right roles, and then **use the
upload form**.

## 1. Create a bulk‑upload configuration

1. Go to **Configuration → Media → Bulk upload media**
   (`/admin/config/media/media-bulk-config`). You need the **Administer
   media_bulk_upload configuration** permission.
2. Click **Add** and fill in the fields:

| Field | What it does |
|---|---|
| **Label** | A human name for this form. Its machine id also becomes part of the per‑configuration permission name. |
| **Media types** | The media types this form is allowed to create. The form's accepted file extensions and maximum file size are taken from these types' source file/image fields. |
| **Form mode** | An optional media form mode embedded in the upload form, so editors can set fields shared by all the selected types at once. Defaults to *None*; if a chosen type lacks the mode, it falls back to the default media form. |
| **Upload location** | The stream location files are uploaded to before being moved into each type's target directory. Defaults to `temporary://media-bulk-upload`. You can use `public://`, `private://`, etc. |

3. Save. The upload location is validated on save — it must be a valid stream
   scheme, and for `private://` you need a configured private files directory (and
   likewise a temp directory for `temporary://`).

You can create as many configurations as you like, each scoped to a different set
of media types. Configurations are exportable configuration, so they deploy between
environments with `drush config:export`.

## 2. Grant the permission for the form

Each configuration has its **own** "use" permission, so access is granted
per‑form:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find the permission named **"{your label} : Use upload form"** (machine name
   `use {id} bulk upload form`, e.g. `use images bulk upload form`).
3. Tick it for the roles that should be allowed to use that form, and save.

From the command line this is:

```bash
drush role:perm:add editor 'use images bulk upload form'
```

There is also the broader **Administer media_bulk_upload configuration** permission,
which lets a user create, edit, and delete configurations and reach the
`/media/bulk-upload` landing list.

## 3. Use the upload form

- Editors visit **`/media/bulk-upload`**. If they can use more than one form, they
  see a list; if only one, they are redirected straight to it. A specific form lives
  at `/media/bulk-upload/{configuration}`.
- The form presents a multi‑file upload (or a DropzoneJS drop area if the
  sub‑module is enabled), accepting only the extensions and sizes the selected media
  types allow.
- On submit, the module runs a **batch**: each file is validated (extension,
  per‑type maximum file size, and image min/max resolution for image types), moved
  into its media type's target directory, and saved as a new media entity of the
  matching type. Files whose extension no selected type accepts are rejected.

That's it — the uploaded files now appear in your media library as fully‑formed
media entities.
