<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Resizer (image_resize) — agent index

Resizes and re-encodes **managed image files in place**. On file insert it enqueues matching
files; a **cron queue worker** loads each file, optionally scales it to a max/min bounding box
(aspect preserved) and optionally converts its format (WebP/AVIF/etc.), then overwrites the
original and updates the file entity plus referencing image fields. Package `Other`. Depends on
core **`file`** and **`image`**. Core requirement `^10.2 || ^11`. License GPL-2.0-or-later.
Version 1.0.0-beta1 (dir `1.0.x`). **The conversion is destructive — it replaces the original.**

- **Settings form, config object, schema keys, requeue batch** →
  [config/settings.md](config/settings.md)
- **The queue worker: enqueue trigger, resize/convert pipeline, ImageMagick quality hook** →
  [queue/worker.md](queue/worker.md)

## What it provides (from source)

- **Hook** `image_resize_file_insert()` (`image_resize.module`) — on any file insert, if the file's
  MIME type is in `mimetypes` and (when `min_filesize` is set) its size exceeds it, creates an item
  on queue `image_resize` holding the file id.
- **Queue worker** `ImageResize` (`src/Plugin/QueueWorker/ImageResize.php`), `@QueueWorker` id
  **`image_resize`**, `cron = {"time" = 60}` — the actual resize/convert engine.
- **Service** `image_resize.imagemagick_event_subscriber` →
  `EventSubscriber\ImagemagickEventSubscriber` — subscribes to `imagemagick.convert.preExecute`
  (priority 100, string event name to avoid a hard imagemagick dep) and injects `-quality <n>`
  while the worker is resizing.
- **Settings form** `Form\ImageResizerSettingsForm` (extends `ConfigFormBase`) at route
  `image_resize.settings` → **`/admin/config/media/image-resizer`**, requirement
  `_permission: 'administer site configuration'`; menu link under *Configuration → Media*.
- **Helper** `SizeCalculator::resize()` (`src/SizeCalculator.php`) — pure static that computes the
  new width/height for the `min`/`max` mode, or `NULL` if no resize is needed.
- **Config**: object `image_resize.settings` (schema `config/schema/image_resize.schema.yml`,
  install defaults `config/install/image_resize.settings.yml`).

## Not present

No permissions of its own, no Drush commands, no plugin types, no REST/JSON routes, no controller.
The only route is the admin settings form. There is **no on-demand image-proxy/resize endpoint**:
resizing runs only from the queue (cron / `drush queue:run image_resize`), never from a
request-supplied URL or path.

## Dependencies & optional integrations

- Hard: core `file`, `image`.
- Optional (loose, feature-detected): `imagemagick` (enables the `quality` override — the event
  subscriber and `ImagemagickToolkit` checks), `file_mdm` (`file_metadata_manager`, injected if
  present), `stage_file_proxy` (if its `origin` is configured, a missing local file is fetched
  from that origin before resizing — see [queue/worker.md](queue/worker.md)).
