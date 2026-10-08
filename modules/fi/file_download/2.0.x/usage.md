<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Download provides field formatters for file and image fields that render a link which forces the browser to download the file (as an attachment) instead of opening it inline.

---

The module adds two field formatters. `file_download_formatter` (for `file` and `image` field types) renders each referenced file as a download link whose title you can configure — the filename, the parent entity's title, the field description, nothing (icon-only), or custom token-aware text — and can optionally append the file size. `file_download_uri_formatter` renders just the download URL string (relative or absolute). Both point at a module-provided route, `/file-download/download/{scheme}/{fid}`, whose controller (extending core's `FileDownloadController`) streams the file with `Content-Disposition: attachment` and the correct MIME/length headers, so any file — including private-scheme files — downloads directly. Access is gated by the `access file download` permission and still honours core's `hook_file_download` access hooks; the controller validates that the requested scheme matches the file's actual stream wrapper. The module also registers two Twig templates (`download-file-link`, `download-file-title`), a `file:type` token (short MIME, e.g. `pdf`), and integrates with the optional `file_download_counter` submodule to tally downloads. There is no global settings page — everything is configured per field on the entity's *Manage display*.

---

- Turn a document (PDF, DOCX) file field into a one-click "Download" link instead of an inline preview.
- Force images to download to disk rather than open in the browser tab.
- Offer private-scheme files for download through an access-controlled route.
- Show a download link labelled with the file's own filename.
- Label download links with the parent node's title (e.g. "Download Annual Report").
- Use the file's description field as the link text.
- Render an icon-only download control (title set to "Nothing").
- Provide custom link text with tokens, e.g. `Download [file:name] ([file:type])`.
- Append the human-readable file size next to each download link.
- Output only the raw download URL with `file_download_uri_formatter` for use in a custom template or Views.
- Emit an absolute download URL (including domain) for use in emails or feeds.
- Build a "resources" listing where every attachment is a forced download.
- Restrict who can download files by granting `access file download` to specific roles.
- Serve downloadable software/zip releases from a file field.
- Give editors a download button on media-style content without exposing the raw file path.
- Combine with `file_download_counter` to count how many times each file is downloaded.
- Provide downloads for multi-value file fields (each file gets its own link).
- Present course or membership materials as attachments behind a permission.
- Use the `file:type` token to show the file extension (e.g. "PDF") in link text.
- Theme the download link markup via the `download-file-link` Twig template.
- Ensure correct `Content-Type` and `Content-Length` headers so downloads are reliable across browsers.
- Replace core's inline "Generic file" formatter where you specifically want attachment behaviour.
- Offer the same file as a download from several displays (teaser, full) with different labels.
