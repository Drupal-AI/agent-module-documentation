<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Segmentio (segmentio) — agent index

**Loads Segment (analytics.js) with a configured write key and a pluggable identify/page/track payload passed via drupalSettings.**

- **Version:** 2.0.x · **Package:** Statistics · **Core:** ^9.2 || ^10 || ^11
- **Config route:** `segmentio.admin_settings_form` → `/admin/config/system/segmentio` (permission `administer segmentio`).
- **Config:** `segmentio.settings` — `segmentio_write_key`, `segmentio_privacy` (1=on, honors DNT), `segmentio_track` (list of `module:hook` callbacks).
- **Mechanism:** `hook_page_attachments()` attaches library `segmentio/segmentio` + `drupalSettings.segmentio` (write_key + variables). Callbacks via `hook_segmentio_info()`; built-ins `segmentio_segmentio_user` (identify userId + name/email), `segmentio_segmentio_node`. Queue events with `segmentio_set_track_event()` (uses `$_SESSION` + page-cache kill switch). API doc: `segmentio.api.php`.

**Security/privacy:** admin form gated by `administer segmentio`; no anonymous or mutating endpoints. Report (privacy, by design): when the user callback is enabled, the authenticated **user's name and email are emitted into page drupalSettings** (`segmentio_segmentio_user`, segmentio.module) and sent to Segment — PII/GDPR consideration; the Segment write key is public client-side by design. No code-level vulnerability.

See [configure/settings.md](configure/settings.md) and [api/tracking.md](api/tracking.md).