<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Uppy (uppy) — agent index

**Field widget that replaces the core file/image upload control with the Uppy JS uploader + resumable TUS chunked transfer.**

- **Version:** 3.0.x (release 3.0.1)
- **Core:** 9.3 || ^10 || ^11
- **Provides:** field widget plugin `uppy_widget` (`UppyWidget extends FileWidget`) for `file` and `image` fields.
- **Settings (per form-display):** `auto_proceed`, `file_sources` (dashboard/drag-drop), `uploader` (tus), `chunk_size` (bytes, default 2MB).
- **Library:** `uppy/uppy_widget` (`js/uppy.min.js`, `js/uppy_integration.js`, `css/uppy.min.css`); depends on core jquery/drupalSettings/once.
- **Client callback:** `js/uppy_integration.js` POSTs to `tus/upload-complete/{uploadKey}` to get the saved `fid`.
- **No routing.yml / controller / permissions** in this module.

**Security:** The widget extends core `FileWidget`, so core's server-side validators are retained — `file_validate_size` and the field's `file_validate_extensions` are passed through, and mirrored into Uppy's client-side `restrictions`. **Important:** this module ships **no upload route of its own**; the `tus/upload-complete/{uploadKey}` endpoint and the actual server-side receipt/persistence of bytes are provided by a separate TUS server component — real access control and MIME/extension enforcement on the uploaded file live *there*, not here. The JS `restrictions` are client-side only and are not a security boundary. No anon upload route exists in this module; no TLS/secret issues in its code.

See [configure/widget.md](configure/widget.md).
