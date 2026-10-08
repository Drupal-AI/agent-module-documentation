# Exporting contact submissions to CSV

No settings page — the feature is an **operation** on contact forms plus a per-export form.

## Where it appears

- `hook_entity_operation_alter()` adds **"Export submissions"** to each contact form row on
  `/admin/structure/contact` (weight 50).
- Direct route: `entity.contact_form.export_form` at
  `/admin/structure/contact/manage/export` (choose a form) or with the `contact_form` set to
  export a specific one.
- Both this and the download route require the **`export contact form messages`** permission.

## Export form options (`ContactStorageExportForm`)

When a form has at least one submission:

- **Only export new messages since the last export** (`since_last_export`) — checkbox;
  disabled when there are no new messages. Uses the per-form watermark (see below).
- **Advanced → Columns to be exported** — checkboxes of the message's fields (the `uuid` field
  is always excluded); all selected by default. Required.
- **Advanced → File name** — defaults to `<form>-<Y-m-d--h-i-s>.csv`; must end in `.csv` and is
  sanitised (alphanumerics + `-_. `).
- **Advanced → Created date format** — a select of all site date formats, default `medium`.

Submitting queues a **Batch** (25 messages per step) that serializes rows and appends them to a
temporary file, then redirects to the **download form**
(`contact_storage_export.contact_storage_download_form`), which streams the CSV as an
attachment via a private tempstore entry (cleaned up after 60 minutes).

## "Since last export" watermark

Tracked per form in the key/value store, not in config:

```php
\Drupal\contact_storage_export\ContactStorageExport::getLastExportId($form_id); // int, 0 if none
\Drupal\contact_storage_export\ContactStorageExport::setLastExportId($form_id, $last_id);
```

Key/value collection name is `contact_storage_export.<form_id>`, key `last_id`. After a "since
last export" run finishes, the highest exported message id is stored there.

## File storage

Exports are written under `private://contact_storage_export/<uid>-<timestamp>/` when a private
filesystem is configured, otherwise `temporary://…`. Files are Drupal temporary files (garbage
-collected); the download form loads the file by id and sends it with the chosen filename.

## Notes / limitations

- There is **no column/format config persisted** — every export chooses options fresh.
- Export honours entity access (`accessCheck(TRUE)` on the message query).
