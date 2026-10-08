<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Saved Searches lets a visitor save a Search API search and be emailed when new matching results appear — the "alert me about new listings like this" feature familiar from job boards, marketplaces and property sites. A saved search is a `search_api_saved_search` content entity; a `search_api_saved_search_type` config/bundle entity controls how it behaves.

---

Each saved search stores the exact query that ran on the page (including any Facets, Views or other filters) so its results match what the visitor saw. The bundle entity (`search_api_saved_search_type`) decides which search displays can be saved, which notification methods are used, the schedule of notifications, and how "new" results are detected — either by a date field ("created after last check") or by diffing result IDs against the `search_api_saved_searches_old_results` table. On cron (`hook_cron` → `NewResultsCheck::checkAll()`, batched via `cron_batch_size`), each due query is re-run and new results are delivered through a pluggable notification plugin (`search_api_saved_searches_notification`); the built-in `email` plugin sends Token-templated mails. Anonymous visitors save a search by entering an email address and confirming it via an activation link, and each saved search can be viewed, edited or deleted from links in the email. Visitors save searches through the "Save search" block, which renders the create form for whichever Search API query executed on the same page — so the underlying search view must have caching disabled. Registered users get a per-user Views listing of their saved searches, and their searches are automatically claimed, updated on email change, or deactivated when they are blocked. A `check-all` Drush command mirrors the cron run for manual or scheduled execution.

---

- Let visitors save a search and be alerted to new results.
- Email a job seeker when new matching vacancies are indexed.
- Notify buyers when new property listings match their filters.
- Alert marketplace users to new items in a saved category search.
- Send a daily, weekly or hourly digest of new matches.
- Let anonymous visitors subscribe by email with a confirmation link.
- Offer different alert schedules and rules per saved-search type.
- Give registered users a page listing and managing their saved searches.
- Save a faceted or Views-filtered search exactly as displayed.
- Let users create a saved search without first running the search.
- Detect new results by a "created" date field for efficiency on large indexes.
- Cap how many new results each notification email includes.
- Add a custom delivery channel (SMS, push) via a notification plugin.
- Place a "Save search" block below any Search API search results.
- Drive re-engagement by pulling visitors back to new content.
- Automatically remove a user's saved searches when the account is deleted.
- Stop notifications when a user is blocked or loses the "use" permission.
- Run alert checks from cron or on demand with Drush.
- Throttle cron work with a configurable batch size.
- Customize activation and notification email subject/body with tokens.
