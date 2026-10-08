<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Retroactive clean form, route, permission & state

For cleaning images that were uploaded **before** the module was enabled. New uploads are handled
automatically by the file-insert hook (see [api/processor.md](../api/processor.md)); this form is optional.

## Route, menu & permission

- Route `exif_manipulate.clean_images_form` (`exif_manipulate.routing.yml`):
  path `/admin/config/media/exif_manipulate`, `_form: Drupal\exif_manipulate\Form\ExifManipulateForm`,
  requirement `_permission: 'administer exif manipulate'`.
- Menu link (`exif_manipulate.links.menu.yml`): "EXIF Manipulate" under
  `system.admin_config_media` (Configuration → Media).
- Permission (`exif_manipulate.permissions.yml`): `administer exif manipulate`
  ("Administer EXIF Manipulate", `restrict access: true`).

## Form: `Form\ExifManipulateForm`

Extends `ConfirmFormBase` (so it renders a standard confirm form with CSRF protection; submit is POST),
form id `exif_manipulate_clean_images_form`. Injects `queue` (`QueueFactory`) and `state`.

- `buildForm()`: reads state `exif_manipulate_clean_exif_data_total` (default 0); if a previous run set a
  total, computes progress = total − `queue->numberOfItems()` and shows a warning
  "Clean-up in progress, @progress of @total (@percentage %)". Adds a required `directory` textfield in a
  `details` element, default value `sites/default/files`.
- `validateForm()`: `trim($directory, '/')` then requires `is_dir($directory)`, else sets an error.
- `submitForm()`: `getFilesInDir($directory)` collects file URIs, creates one queue item
  `['uri' => $file]` per file in queue `exif_manipulate_clean_exif_data`, stores the count in state
  `exif_manipulate_clean_exif_data_total`, shows "The images have been queued for cleaning." and
  redirects back to the form. Question: "Are you sure you want to clean the EXIF data of the directory?";
  confirm button "Clean images"; cancel → `system.admin_config_media`.
- `getFilesInDir($directory)`: `scandir()` the directory, skip `.`/`..`, convert a `sites/`-relative path to
  a `public://` URI (via `PublicStream::basePath()`) or accept an existing `public://` path, recurse into
  subdirectories, and append each file URI to `$this->files`.

## Runtime

Queued items are drained by the `exif_manipulate_clean_exif_data` QueueWorker on cron
(`time = 60` per run), each calling the processor service. There is **no config object and no config schema**
— the only persisted state is the two queue/state keys, both removed on uninstall.

## Operating notes

- Retroactive cleaning rewrites files in place — back up first.
- The queue is processed by cron; run `drush queue:run exif_manipulate_clean_exif_data` (or wait for cron)
  to process immediately. Progress is shown on the form until the queue drains.
- Only JPEG/TIFF among the queued files are actually modified (others are skipped by the processor's MIME match).
