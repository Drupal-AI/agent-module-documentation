<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Page Feedback (page_feedback) — agent index
**Anonymous 'was this page helpful?' block that stores feedback entities with a permission-gated admin list and CSV export.**

- **Version:** 1.0.x  **Core:** ^10.3 || ^11
- **Entity:** `page_feedback` (fields: helpful bool, feedback string_long, entity_id/type, current_url, created/changed).
- **Block:** `PageFeedbackBlock` renders `PageFeedbackForm` (Ajax, Yes/No + comment).
- **Routes:** collection `/admin/content/page-feedback` (perm `view page feedback`); export (perm `administer page feedback` + `_csrf_token`); delete forms (entity access).
- **Permissions:** `view page feedback`, `administer page feedback` (restricted).
- **Security:** submission is intentionally anonymous but hardened — flood limit (HMAC-hashed IP), required JS token, optional Honeypot, 1000-char cap, query string stripped from stored URL. Reads/exports/deletes are permission-gated; no IDOR. Comments render via `#markup`+`nl2br` (admin XSS filter applies — scripts/handlers stripped; benign inline HTML tags survive). Reviewed sound.

See [configure/block.md](configure/block.md)
