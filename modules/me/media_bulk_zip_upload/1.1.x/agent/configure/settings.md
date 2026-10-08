# Configure Media Bulk Zip Upload

Two things must be true before the bulk form is usable for a media type: the type must be
**opted in** in this module's settings, and the user must hold the per-type permission plus
core create access (see [../permissions/permissions.md](../permissions/permissions.md)).

## Settings form — opt media types in

- Route `media_bulk_zip_upload.settings`, path `/admin/config/media/media-bulk-zip-upload-config`
  (menu link under `system.admin_config_media`), permission `administer media`.
- Form `Drupal\media_bulk_zip_upload\Form\MediaBulkZipUploadSettingsForm` (id
  `media_bulk_zip_upload_settings`), a `ConfigFormBase` editing one config object.
- A single `checkboxes` element `media_types` lists every `media_type` entity; the checked ids
  are saved to `media_bulk_zip_upload.settings:media_types`.

Enabling a type has two effects: `MediaBulkZipUploadForm::checkAccess` will allow that type's
`/media/add/{type}/bulk` route, and the `MediaBulkZipUploadLocalActions` deriver adds a
"Bulk upload {label} media" local action to the media collection page
(`entity.media.collection`, `/admin/content/media`).

### Config object

```yaml
# media_bulk_zip_upload.settings
media_types: {  }   # sequence of enabled media-type ids, e.g. [image, document]
```

Schema: `config/schema/media_library_bulk_upload.schema.yml` (the filename is a leftover; it
declares `media_bulk_zip_upload.settings` as a `config_object` with a `sequence` of strings).
Default install config sets `media_types: {}` (none enabled).

### Set it with Drush / PHP

```bash
drush config:set media_bulk_zip_upload.settings media_types.0 image -y
drush config:set media_bulk_zip_upload.settings media_types.1 document -y
```

```php
\Drupal::configFactory()
  ->getEditable('media_bulk_zip_upload.settings')
  ->set('media_types', ['image' => 'image', 'document' => 'document'])
  ->save();
```

(The form stores the checkboxes value as an `id => id` map; the access check only uses
`in_array($id, $media_types, TRUE)`, so a simple list works too.)

## The bulk-upload form mode

- A media form mode `media_bulk_zip_upload` (form-mode config
  `core.entity_form_mode.media.media_bulk_zip_upload`) is installed. Per type, a form display
  `media.{type}.media_bulk_zip_upload` is created with the **source field and the `name` field
  removed** — the file comes from the ZIP and the name is set from each filename, so only the
  *other* shared fields remain. Whatever you fill in on the bulk form is applied to **every**
  media created from that archive.
- Displays are created automatically: `hook_install` builds one for each existing media type,
  and `media_bulk_zip_upload_form_alter` (in the `.module`) appends
  `_media_bulk_zip_upload_media_type_form_submit` to the media-type **add** form so new types
  get one too (via `_media_bulk_zip_upload_configure_form_display`). Edit the form mode at
  `admin/structure/media/manage/{type}/form-display/media_bulk_zip_upload` to change which
  fields appear.

## How the upload + extraction actually work

Form `MediaBulkZipUploadForm` (`FormBase`), route `media_bulk_zip_upload.form`,
`_admin_route: TRUE`. The `{media_type}` slug is upcast to a `media_type` entity.

1. **Build** (`buildForm`): a single `file` element `zip` (help text limited to
   `Environment::getUploadMaxSize()`), plus the `media_bulk_zip_upload` form display's widgets
   built against a scratch media entity of the chosen bundle, plus an Upload submit.
2. **Validate** (`validateForm`): `file_save_upload('zip', ['FileExtension' => ['extensions' =>
   'zip'], 'FileSizeLimit' => ['fileLimit' => Environment::getUploadMaxSize()]], NULL, 0)` — the
   uploaded archive must have a `.zip` extension and fit under the PHP upload-max size; failure
   sets a form error. The scratch entity's non-source fields are then validated the normal way.
3. **Submit** (`submitForm`): opens the archive with `\ZipArchive`. It reads the target media
   type's **source field** `file_extensions` setting into `$allowed_extensions`, then walks every
   entry:
   - skips directory entries and OSX/dot cruft — any entry ending in `/`, or whose name or
     basename starts with `.` or `_`;
   - skips any entry whose extension is empty or **not in the media type's allowed
     extensions** (strict, case-sensitive `in_array`);
   - queues a batch operation `processOneFile` per surviving entry, passing the stream URI
     `zip://{realpath}#{entry_name}` and the scratch media entity.
   The batch is set and the form redirects to `entity.media.collection`.
4. **Per file** (`processOneFile`, static batch callback): duplicates the scratch media, resolves
   the source field's destination directory as `{uri_scheme}://` + token-replaced
   `file_directory`, reads the entry through the `zip://` stream with `file_get_contents`, and
   writes it with `FileSystem::saveData()` (which renames on collision) using only the entry's
   **basename** as the filename. It then creates a `file` entity owned by the current user, sets
   it on the source field, sets the media name to the filename (truncated to 250 chars),
   validates the media (reporting any violation via the messenger and skipping save on failure),
   dispatches `MediaBulkZipUploadPreSaveEvent`, and saves. A per-type source with an
   image/file constraint still applies during that `validate()`.
5. **Finish** (`done`): a status message "Imported N files as media", or an error prompt to
   review messages.

Because only the entry basename is used for the destination and disallowed extensions are
filtered out before queueing, what an archive may contribute is bounded by the target media
type's own allowed-extensions list — keep that list as tight as you would for the single-file
media add form.
