<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Public files URL replacer overrides Drupal's `file_url_generator` service so that public-file URLs are served from a different base URL (typically a production site), which is handy on dev/test environments restored from a production database without the files directory.

The module registers a service provider (`FilesUrlReplacerServiceProvider`) that swaps the core `file_url_generator` for `CustomFileUrlGenerator`. That subclass overrides `generateString()` and `generateAbsoluteString()`: when the feature is active it takes public-scheme files (excluding `.css`/`.js`) and replaces the local site base URL with the configured URL. An optional "check if local file exists" mode calls `checkIfExists()` so the replacement only happens when the file is absent locally (with special handling that strips image-style path segments so a missing derivative still points remotely).

Configuration lives at `/admin/config/files_url_replacer` behind the `administer files_url_replacer settings` permission (declared `restrict access: true`). The settings form validates that the entered URL is valid and external (`UrlHelper::isValid(..., TRUE)` + `isExternal()`), stores `active`, `url`, and `check`, and invalidates the container on save so the service swap takes effect. Because the replacement target is a single admin-set, validated, external URL — not per-request or user input — there is no path for an unprivileged user to inject arbitrary URLs into rendered file links.
---
The permission is `restrict access: true` (administrator-only). The target URL is validated as a valid external URL. `.css`/`.js` and non-public streams are never rewritten. Saving the form invalidates the service container.
---
- Serve public file URLs from a production host on a local/dev copy of the site.
- Avoid syncing gigabytes of `sites/*/files` when importing a prod database.
- Point image and document links at the live site while developing locally.
- Enable "check if local file exists" so only missing files are proxied.
- Keep locally-regenerated image-style derivatives local, proxy the rest.
- Configure the replacement base URL at `/admin/config/files_url_replacer`.
- Toggle the whole replacement on/off with the "Activate Replacer" checkbox.
- Restrict who can change the replacer via the dedicated admin permission.
- Set up a staging environment that borrows production media transparently.
- Test a theme against real production images without a file copy.
- Fall back to remote files for uploads that don't yet exist on the local disk.
- Exclude CSS/JS aggregation from rewriting (handled automatically).
- Handle multilingual sites where a URL language prefix is in play.
- Provide a lightweight alternative to Stage File Proxy for simple cases.
- Rewrite both relative (`generateString`) and absolute (`generateAbsoluteString`) file URLs.
- Demo content to a client using live assets from a throwaway environment.
- Reset behaviour by unchecking "Activate Replacer" and clearing caches.
- Validate that the configured host is a proper external URL before saving.
