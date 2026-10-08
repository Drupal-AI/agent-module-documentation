<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FitVids — agent index

Attaches the FitVids.js jQuery library site-wide so embedded videos scale fluidly to their
container while keeping aspect ratio. All behaviour comes from one config object and a page
attachment. No plugins, no Drush.

- **Settings (`fitvids.settings`: selectors / custom_vendors / ignore_selectors), admin route, permission, library path** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config object `fitvids.settings`: `selectors` (default `.node`),
  `custom_vendors` (default `https://youtu.be`), `ignore_selectors` (default empty).
  Each value is newline-separated.
- Admin form: `/admin/config/media/fitvids` (route `fitvids.admin`), permission
  `administer fitvids`.
- `hook_page_attachments` exports the three settings to `drupalSettings.fitvids` and attaches
  libraries `fitvids/fitvids` + `fitvids/init`. Library JS expected at
  `/libraries/fitvids/jquery.fitvids.js`.
