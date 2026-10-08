# Enable & configure Editor File Upload

Per text format, at **Admin → Config → Content authoring → Text formats and editors**
(`/admin/config/content/formats`, route `filter.admin_overview`).

1. Edit a **CKEditor 5**-based text format.
2. Drag the **File** (paperclip) button from *Available buttons* into the *Active toolbar*
   (toolbar item `drupalInsertFile`).
3. Open the **File upload** vertical tab under *CKEditor 5 plugin settings* and set:
   - **Enable file uploads** (`status`) — turn uploading on; the fields below appear only when on.
   - **File storage** (`scheme`) — stream wrapper (e.g. `public`, `private`); shown only when
     more than one writable wrapper exists.
   - **Upload directory** (`directory`) — path relative to the files dir.
   - **Allowed file extensions** (`extensions`) — **required**; space/comma separated, no dots
     (prevents unsafe uploads).
   - **Maximum file size** (`max_size`) — blank = PHP upload max.
4. Save.

## Config storage
Stored in the editor entity's CKEditor 5 plugin config under
`ckeditor5.plugin.editor_file_file` (schema `editor_file.schema.yml`). The plugin
(`Drupal\editor_file\Plugin\CKEditor5Plugin\File`, `@internal`) declares the allowed element
`<a href data-entity-uuid data-entity-type>`.

## Notes
- If the "Limit allowed HTML tags" filter is on, confirm the `<a>` tag keeps the
  `data-entity-type` and `data-entity-uuid` attributes (needed for file-usage tracking).
- The upload dialog is served at `/editor_file/dialog/file/{filter_format}`
  (`EditorFileDialog`), gated by the format's `use` access.
- Install **editor_advanced_link** to add title/id/class attributes to the inserted link.
- CKEditor 4 settings are migrated automatically on first configure.
