# Configuration

All of Image Resizer's options live on one settings form. **Read the warning below
before you save anything** — the module rewrites original files and the change cannot
be undone.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Media → Image Resizer**, or navigate directly to
   `/admin/config/media/image-resizer`.

## The settings

- **Image MIME types to convert** — choose which source types the conversion applies
  to (for example JPEG and PNG). Only the types you select are processed.
- **Resize mode** — pick one:
  - **Minimal** — ensures images keep *at least* the given size. Using 3000×3000, an
    image becomes something like 3000×4000 or 4000×3000; very wide or narrow images
    stay large (e.g. 8000×3000).
  - **Maximal** — ensures images stay *below* the given size. Using 3000×3000, an
    image becomes something like 2000×3000 or 3000×2000; very wide or narrow images
    can become quite small (e.g. 500×3000).
- **Target format** — convert to any format the chosen toolkit supports, such as
  **WebP** or **AVIF**. Note AVIF can take considerably longer to encode and may not
  be fully supported everywhere yet.
- **Quality (ImageMagick only)** — set the conversion quality. Set this *higher* than
  the quality you use on image styles: these converted images are the *source* for
  image styles, and applying lower quality repeatedly compounds the loss. Different
  formats use different quality scales.
- **Minimum file size** — skip images below this size, so tiny images aren't checked
  and processed needlessly.

Save the form.

## Processing images

Conversion runs through Drupal's **queue** rather than instantly:

- **Existing images** — optionally add existing images that match your criteria to
  the queue (from the settings page).
- **Run the queue** — cron processes the queue for up to 60 seconds per run, or you
  can run it on demand with:

  ```bash
  drush queue:run image_resize
  ```

- **New images** — the same settings are applied to newly created images
  automatically, via cron, so an image may be updated some time *after* it is
  uploaded. When that happens, image‑style derivatives need to be regenerated
  (flushed) to pick up the new source.

## Important caveats

- **The conversion is permanent** — it rewrites the original file. Back up first.
- Drupal stores image width/height on image *fields*, not on file entities. The
  process updates image fields based on `file_usage` data, but only the **current
  default revision** — pending, forward and past revisions are not updated.
