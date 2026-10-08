<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Page Feedback collects lightweight "Was this page helpful?" answers from visitors through a block, stores each as a `page_feedback` content entity, and gives editors a filterable admin list with CSV export. The block's wording (question, comment prompts, notice) is configurable per placement.

---

The block renders an Ajax form (`PageFeedbackForm`) with a Yes/No radio and an optional comment (max 1000 chars), and its four wording fields can be overridden in the block settings (Question, comment box after Yes, comment box after No, notice) — empty fields keep the module's translated defaults. Submissions are open to anonymous visitors by design, but hardened several ways: a per-IP flood limit (5 per 300s, IP stored only as an HMAC hash, never in clear text), a required JS token so no-JS bots are rejected, optional Honeypot integration when that module is present, and a comment length cap. Each record captures the answer, the trimmed comment, and the current URL with its query string stripped to avoid storing personal data. Reading the collected feedback requires the `view page feedback` permission; deletion, bulk actions and CSV export require `administer page feedback` (the export route also enforces a CSRF token). There is no anonymous read path and no per-item IDOR — the listing and export are entity/permission gated. Stored comments are rendered in the admin list via `#markup` with `nl2br()` (so Drupal's admin XSS filter applies, stripping scripts/event handlers). Runs on Drupal 10.3, 11 and 12.

---
- Ask "Was this page helpful?" on any page via a block.
- Customize the block's question and comment prompts per placement.
- Collect an optional free-text comment with each answer.
- Store feedback as queryable content entities.
- Browse and filter feedback at `/admin/content/page-feedback`.
- Export filtered feedback to CSV (CSRF-protected route).
- Bulk-delete feedback with the entity action.
- Rate-limit submissions per IP (flood: 5 / 5 min).
- Keep visitor IPs out of storage (HMAC-hashed flood key).
- Require JavaScript to submit, blocking simple bots.
- Add Honeypot protection automatically when Honeypot is installed.
- Cap comment length at 1000 characters.
- Strip query strings from the recorded URL to avoid storing PII.
- Grant read-only feedback access with `view page feedback`.
- Restrict deletion/export to `administer page feedback`.
- Prune SQL-injection-probe spam via the cron SpamCleaner.
- Filter the admin list by helpful/not-helpful and URL.
- Show a translatable thank-you confirmation after submit.
- Remember a visitor's prior answer in localStorage (per path).
- Track which pages users report as unhelpful.
- Place the block only on content pages, not admin.
- Translate the feedback UI (ships a French .po).
- Run on Drupal 10.3, 11 or 12.
