<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Page Feedback (page_feedback) — agent index
**Anonymous 'was this page helpful?' block (configurable wording) that stores feedback entities with a permission-gated admin list and CSV export.**

- **Version:** 1.1.x  **Core:** ^10.3 || ^11 || ^12  **PHP:** >=8.1
- **Entity:** `page_feedback` (fields: helpful bool, feedback string_long, entity_id/type, current_url, created/changed; `internal = TRUE`).
- **Block:** `PageFeedbackBlock` (id `page_feedback_block`, category Content) renders `PageFeedbackForm` (Ajax, Yes/No + comment). Block settings override 4 wording fields (question, yes_title, no_title, notice); empty = translated defaults.
- **Routes:** collection `/admin/content/page-feedback` (perm `view page feedback`); export `/admin/content/page-feedback/export` (perm `administer page feedback` + `_csrf_token`); delete + delete-multiple forms (entity access).
- **Permissions:** `view page feedback`, `administer page feedback` (restricted).
- **Cron:** `SpamCleaner` deletes SQL-injection-probe rows (once/day, near midnight); stale CSV exports swept.
- **Security:** submission is intentionally anonymous but hardened — flood limit (HMAC-hashed IP, 5/300s), required JS token, optional Honeypot, 1000-char cap, query string stripped from stored URL. Reads/exports/deletes are permission-gated; no IDOR. Comments render via `#markup`+`nl2br` (admin XSS filter applies — scripts/handlers stripped; benign inline HTML survives). Wording overrides go through `FormattableMarkup` (escaped once). Reviewed sound.

See [configure/block.md](configure/block.md)
