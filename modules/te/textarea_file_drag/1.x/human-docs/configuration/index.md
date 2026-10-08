# Configuration

Textarea File Drag'n'Drop has two things to get right: a short settings form, and
the permission that decides who can upload.

## Open the settings form

Go to **Configuration → Media → Textarea File Drag'n'Drop**
(`/admin/config/media/textarea-file-drag`). You need the **Administer site
configuration** permission to open it.

## The settings

- **Allowed extensions** — a space-separated allowlist of file extensions that
  may be dropped. The default is:

  ```
  jpg jpeg png gif webp svg zip rar 7z xls xlsx doc docx pdf txt
  ```

  This is matched against the file's extension. Tighten it to only what you
  actually need.

- **Upload path** — the destination for uploaded files, given as a stream-wrapper
  path. The default is `public://inline`. Files are moved straight here in the
  public filesystem.

## The permission

Grant `dragndrop files to textarea` (on **People → Permissions**) only to trusted
roles. This single permission both:

- switches on the drop zone on textareas, and
- authorises the `/ajax/textarea-file-drag` upload endpoint.

So anyone who holds it can upload files through the endpoint. Do not give it to
untrusted or anonymous users.

## Storage notes

- **No managed file entity is created.** Files are moved directly into the public
  filesystem, so Drupal does not track them, and they are not garbage-collected
  when the referencing content changes. Housekeeping is on you.

The filename itself is sanitised automatically (transliterated and stripped to
safe characters) when the file is stored.
