<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Suppress Drupal status, warning, and error messages whose text matches admin-configured patterns.

---

Error Squelch removes on-screen status, warning, and error messages that match a list of admin-configured patterns, filtering them in `hook_preprocess_status_messages()` just before the status-messages template renders. Patterns match either as case-insensitive substrings (the default) or as full PHP regular expressions when regex mode is enabled. It is an admin/ops noise-reduction tool: suppression is purely cosmetic and does not fix whatever condition produced a message, so it is meant to quiet known-benign notices while a proper fix is pending, not to mask real problems. An optional log toggle records every suppressed message to the `error_squelch` channel for an audit trail, a test mode injects a known message so operators can verify the filter works, and Drush commands manage the pattern list from the CLI. Requires Drupal 10.3+ or 11; no other modules; Drush 11+ only for the CLI commands.

---

- Hide a payment gateway's persistent "Stripe API is running in test mode" notice.
- Suppress missing-file warnings from s3fs or media modules during an in-progress file sync.
- Keep screenshots clean during a live upgrade or migration.
- Produce clean training videos free of known-benign warnings.
- Reduce noise in client demos and sales walkthroughs.
- Quiet chatty third-party contrib modules with unhelpful default warnings.
- Remove a recurring theme-hook-suggestions notice from admin pages.
- Silence a known deprecation notice while awaiting an upstream fix.
- Match messages by case-insensitive substring for simple fixed notices.
- Match messages by PHP regular expression for variable text.
- Suppress only specific message types (status, warning, or error) by pattern text.
- Enable an audit trail by logging suppressed messages to the `error_squelch` channel.
- Review suppressed messages later at Reports > Recent log messages.
- Verify a pattern works using test mode before relying on it in production.
- Manage patterns from the CLI with `drush error-squelch:list` (alias `esl`).
- Add a pattern from the CLI with `drush error-squelch:add` (alias `esa`).
- Remove a pattern from the CLI with `drush error-squelch:remove` (alias `esrm`).
- Script pattern changes into a CI/CD deploy pipeline.
- Restrict pattern management to trusted roles via the "Administer Error Squelch" permission.
- Reduce clutter on an on-call operations dashboard.
- Configure suppression entirely through exported configuration (`error_squelch.settings`).
- Temporarily quiet noise during a maintenance window, then remove the pattern afterward.
- Keep on-screen messaging tidy for a client-facing editorial team.
