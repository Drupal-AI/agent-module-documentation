Automatically compress (and optionally convert to WebP) images on file save using PHP GD, tracking per-file byte savings.

---

(ADFS) Image Optimizer is an optional submodule of the Advanced FileSystem project. When enabled, it hooks into `hook_file_presave` and runs the local GD-based `ImageOptimizerService` on every newly saved file whose MIME type matches the configured rules. For each matching image it optionally downscales to a maximum width/height, re-encodes at the configured JPEG quality or PNG compression level, and can additionally write a `.webp` copy next to the original. To avoid making files worse, it re-encodes into a temporary buffer first and — when `skip_if_larger` is on — keeps the original if the re-encoded version is not smaller; it also skips animated GIFs. Cumulative bytes saved are tracked in Drupal State and each file's outcome is logged to the `adfs_image_optimizer_log` table. A settings form, a bulk-optimize batch form, and a log page with stats live under `/admin/config/media/advanced_filesystem/image-optimizer`, and two Drush commands (`adfs:image-optimizer:run`, `adfs:image-optimizer:stats`) bulk-process existing files and report savings. All processing is done locally through GD — there is no external optimization service. Administration is gated behind one restricted permission.

---

- Automatically shrink uploaded JPEG/PNG/WebP images without editor action.
- Re-encode JPEGs at a controlled quality to cut file size site-wide.
- Set a PNG compression level for smaller lossless images.
- Cap maximum image width/height so oversized uploads are downscaled on save.
- Generate a `.webp` copy alongside each original for modern-format delivery.
- Track total bytes saved and the number of images optimized across the site.
- Keep a per-file optimization log (original size, optimized size, outcome, WebP flag, date).
- Avoid regressions by skipping saves where the re-encoded file would be larger than the original.
- Preserve animated GIFs by detecting and skipping them (no frame loss).
- Restrict optimization to a specific set of MIME types via a newline list.
- Bulk-optimize an existing image library with `drush adfs:image-optimizer:run`.
- Limit a bulk run to a MIME type, a specific field, a bundle, a single FID, or a count.
- Dry-run a bulk optimization to preview which files would change.
- Skip files already recorded in the log during a bulk run (`--skip-optimized`).
- Report global savings and the last ten optimizations with `drush adfs:image-optimizer:stats`.
- Review outcomes and filter by result on the admin log page.
- Reset cumulative savings counters when starting a new measurement period.
- Reduce page weight and improve performance by serving smaller images.
- Run entirely on the server with GD — no third-party API, credentials or network calls.
- Roll optimization defaults across environments via exportable config.
