<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Public files URL replacer (files_url_replacer) — agent index

**Overrides `file_url_generator` to serve public-file URLs from an admin-configured external base URL, optionally only when the file is missing locally.**

- **Version:** 1.0.x
- **Core:** ^9.4 || ^10 || ^11
- **Config route:** `files_url_replacer.settings` → `/admin/config/files_url_replacer` (`_permission: administer files_url_replacer settings`, `restrict access: true`)
- **Permission:** `administer files_url_replacer settings` (`src/../files_url_replacer.permissions.yml`)
- **Service override:** `FilesUrlReplacerServiceProvider` swaps `file_url_generator` → `CustomFileUrlGenerator` (`generateString` / `generateAbsoluteString`)
- **Config keys:** `active`, `url`, `check`

**Security:** Admin-only config route (dedicated restricted permission); the rewrite target is a single validated *external* URL (`UrlHelper::isValid + isExternal`), not user/request input, so an unprivileged user cannot inject arbitrary URLs into output. No anonymous or mutating endpoints.

See [configure/settings.md](configure/settings.md)
