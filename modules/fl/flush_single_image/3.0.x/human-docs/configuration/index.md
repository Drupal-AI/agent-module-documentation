# Configuration

Flush Single Image Styles works as soon as it is enabled — there is nothing you *must*
set up. This page covers the two forms it provides, the permissions that decide who can
use them, and the other ways to trigger a flush.

## The flush form

This is the everyday tool. Go to
**`/admin/config/media/image-styles/flush-single`** and enter the **source image
path** of the file you want to refresh — a Drupal stream‑wrapper path such as
`public://assets/foo/bar/image.jpg`. Submit, and the module clears the styled
derivatives that were generated for that file, so they regenerate the next time they
are requested (or immediately, depending on how you invoke it).

Use this whenever one image is stale: a file replaced in place under the same filename,
a corrected crop, or a single derivative that was generated wrongly.

## The settings form

The module's settings form (route `flush_single_image.settings.form`) lives at
**`/admin/config/flush-single-image/settings`**. It holds the module's configuration
options and is intended for administrators — it is guarded by the *Administer
flush_single_image* permission, which is marked as a restricted permission.

## Permissions

The module deliberately splits its permissions so editors do not need configuration
rights just to refresh an image:

- **Administer flush_single_image** *(restricted)* — required for the settings form and
  the flush form under `/admin/config`. Grant this only to trusted administrators.
- **Flush media image** — lets a user flush an image they have just replaced via the
  **bulk operation on the media listing**, without holding any configuration rights.
  This is the permission to give content editors.

Review these under **People → Permissions** and assign them according to who needs to
correct images versus who administers the site.

## Other ways to flush

Beyond the forms, the same operation is available for automation:

- **Drush** — ideal for deployment steps or scripts:

  ```bash
  drush flush_single_image public://assets/foo/bar/image.jpg --check-styles
  ```

- **Media bulk action** — on the media listing, select items and choose the flush
  action (this is why the module depends on core's Action module).
- **Service class** — for custom code, call the `flush_single_image` service:

  ```php
  $paths = \Drupal::service('flush_single_image')->flush('public://assets/foo/bar/image.jpg');
  ```

- **Migrate plugin** — in an import pipeline, add a `flush_single_image` process step
  (for example with `action: 'regenerate'`) after copying a file, so incoming images
  refresh their derivatives automatically.

> **Heads‑up: the edge cache is separate.** Flushing a derivative refreshes what Drupal
> generates, but it does not evict a copy already cached by a browser or CDN. If a stale
> image persists for visitors after flushing, you also need to bust the browser/CDN
> cache for that file.
