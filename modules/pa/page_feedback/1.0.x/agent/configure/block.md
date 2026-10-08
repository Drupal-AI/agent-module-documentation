<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Placing and operating Page Feedback

## Collect
1. Enable the module; the `page_feedback` entity and its routes install automatically.
2. Place the **Page Feedback** block (`PageFeedbackBlock`) on the regions/pages you want a helpfulness prompt.
   The block renders an Ajax Yes/No form with an optional comment; anonymous users may submit.
3. (Recommended) install **Honeypot** — the form auto-adds its protection when the service is available.

## Anti-abuse (built in)
- Flood: `FLOOD_LIMIT=5` per `FLOOD_WINDOW=300s`; identifier is `Crypt::hmacBase64(clientIp, hashSalt)` — no clear-text IP.
- A hidden `js_token` must be present → no-JS bots are rejected in `validateForm()`.
- Comment capped at `FEEDBACK_MAX_LENGTH=1000`; recorded URL has its query string removed.

## Review / export
- Read: `/admin/content/page-feedback` (perm `view page feedback`), filterable via `PageFeedbackFilterForm`.
- Export CSV: `/admin/content/page-feedback/export` (perm `administer page feedback`, CSRF token required).
- Bulk delete via entity action; single delete via entity delete forms.
- `SpamCleaner` runs on cron (`hook_cron`) to prune entries.
