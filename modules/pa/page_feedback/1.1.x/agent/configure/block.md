<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Placing and operating Page Feedback

## Collect
1. Enable the module; the `page_feedback` entity and its routes install automatically. Nothing shows on the front end until the block is placed.
2. Place the **Page feedback** block (`page_feedback_block`, category Content) on the regions/pages you want a helpfulness prompt.
   The block renders an Ajax Yes/No form with an optional comment; anonymous users may submit.
3. (Recommended) install **Honeypot** — the form auto-adds its protection when the service is available (timing check left off).

## Block wording (config)
Edit the placed block to open the **Wording** fieldset (config schema `block.settings.page_feedback_block`). Four optional textfields (maxlength 255) override the shipped, translated defaults:
- `question` — the radios' question. Default: "Was this page helpful?"
- `yes_title` — label of the comment box after Yes. Default: "Tell us more".
- `no_title` — label of the comment box after No. Default: "How can we improve this page?"
- `notice` — text under both comment boxes. Default: "You will not receive a reply. Don't include personal information." "Up to 1000 characters." is always appended and cannot be removed.

Leave a field empty (or whitespace-only) to keep the module's default, which stays translatable. A typed value replaces it in every language (it is not translated by the module, but the block itself can be translated via Configuration Translation). Overrides are rendered through `FormattableMarkup` — escaped once, so no HTML injection. The thank-you message and Send button label are not configurable (but are translatable).

## Anti-abuse (built in, `PageFeedbackForm`)
- Flood: `FLOOD_LIMIT=5` per `FLOOD_WINDOW=300`s, event `page_feedback`; identifier is `Crypt::hmacBase64(clientIp, hashSalt)` — no clear-text IP. Only a saved answer registers against the limit.
- A hidden `js_token` field must be filled by JS → no-JS bots rejected in `validateForm()`.
- Comment capped at `FEEDBACK_MAX_LENGTH=1000` (validated server-side); No answers require a non-empty comment.
- Recorded `current_url` has its query string removed (no PII from `?token=` etc.).

## Review / export
- Read: `/admin/content/page-feedback` (perm `view page feedback`), filterable via `PageFeedbackFilterForm` (helpful state + URL); 25/page.
- Export CSV: `/admin/content/page-feedback/export` (perm `administer page feedback`, `_csrf_token` required); runs as a batch honoring the active filters, delivered via `file_download`.
- Bulk delete via the entity action `page_feedback_delete_action` (sticky Claro bulk bar); single delete via the entity delete forms.
- `SpamCleaner` runs on `hook_cron`: deletes rows whose feedback matches SQL-injection-probe patterns (e.g. `waitfor delay`, `sleep(`, `pg_sleep`, ` or 1=`) or is a bare `1`/`'1'`/`"1"`/starts with `@@`. Runs at most once/day and, after the first run, only around midnight.
