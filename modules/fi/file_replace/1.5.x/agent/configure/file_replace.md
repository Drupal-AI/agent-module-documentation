# file_replace — exposing the replace UI

There is **no settings form and no `configure` route** — `data.json.configure` is `null` and the
module ships no config objects. "Configuration" here means giving users a way to reach the replace
form. Four ways, all pointing at route `entity.file.replace_form` / path
`/admin/content/files/replace/{file}` (`{file}` = file entity ID / fid).

## 1. Direct URL

Visit `/admin/content/files/replace/{fid}` for any permanent file (requires the `replace files`
permission — see permissions doc). The form shows the current file plus one upload widget.

## 2. Entity operation (automatic)

`hook_entity_operation` adds a "Replace" operation (weight 100) to every `file` entity's operations
list for users who can access it — e.g. in the operations dropdown of the admin files listing
(`/admin/content/files`, provided by core File's `file` view / entity list). No setup needed.

## 3. Views field "Link to replace file"

`hook_views_data` registers field `file_replace_link` on the `file_managed` table (handler
`Drupal\file_replace\Plugin\views\field\FileLinkReplace`, extends core `EntityLink`).
In any View based on **Files** (`file_managed`), add the field **"Link to replace file"**; default
link text is "replace" and it carries a `destination` back to the current page. Add it via the Views
UI, or in a View config YAML as a field with `id: file_replace_link` / `plugin_id: file_replace_link`.

## 4. Manual link in a field or template

Per the README, add a link anywhere (e.g. a text field, block, or Twig template) using:

```
admin/content/files/replace/{{ fid }}
```

## Replacement behavior (what the form enforces)

- Upload is validated to the **same file extension** as the original (`FileExtension` upload
  validator); the file widget's `accept` attribute is set to the original MIME type as a hint.
- On save the new upload's bytes are copied over the original URI with `FileExists::Replace`, so the
  **URI, filename, and file entity ID are unchanged**; the file entity is re-saved to refresh size
  and change date, and the temporary upload is deleted.
- If the file is an image and core `image` is enabled, all image-style derivatives for that URI are
  flushed so thumbnails regenerate (module's own `hook_file_replace`).
