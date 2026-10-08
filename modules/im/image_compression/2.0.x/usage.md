<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Compression reduces the file size of JPEG and PNG images, either on upload (via file validation hooks) or in bulk against existing files, using PHP's built-in GD functions and a configurable table of size thresholds and compression rates.

---

Administrators define rows of "image size ≥ X → compress at rate Y%" plus a "compress before upload" toggle at `/admin/config/user-interface/image_compression`. On upload, `hook_file_validate()` (or, when "compress before" is set, a swapped-in upload validator) runs the `image_compression.manager` service, which re-encodes JPEGs with `imagejpeg()` at the matched quality and PNGs with `imagepng()`. A separate batch form at `/admin/config/user-interface/compress_existing_images` walks `sites/default/files`, matches `*.jpg/jpeg/png`, and compresses matching managed files. Both routes require `administer site configuration`.

Security review: compression is done entirely in-process with GD — the module sends nothing to an external service (no TLS/API-key surface) and runs no shell command (no command-injection surface). File selection uses `RecursiveDirectoryIterator` over the site files directory, not user-supplied paths, and both forms are admin-only. No findings.

---

- Compress JPEG and PNG images to save disk and bandwidth.
- Re-encode images with PHP GD (no external service).
- Compress images automatically on upload.
- Optionally compress before file-size validation runs.
- Define size thresholds and compression rates in a table.
- Apply higher compression to larger files.
- Bulk-compress existing files via a batch process.
- Scan `sites/default/files` for jpg/jpeg/png files.
- Gate all configuration behind `administer site configuration`.
- Warn that bulk compression is irreversible.
- Update managed file sizes after compression.
- Improve page performance with smaller images.
- Add multiple size/rate rules dynamically in the form.
- Remove size/rate rules with an Ajax remove button.
- Keep PNGs at maximum GD compression level.
- Integrate with node form image field upload validators.
