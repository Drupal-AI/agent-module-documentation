<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The summary builder + mail — cron, query, hook_mail

## Service

`linkchecker_summary_mail.summary_builder` -> `Drupal\linkchecker_summary_mail\LinkcheckerSummaryMailSummaryBuilder` (`src/LinkcheckerSummaryMailSummaryBuilder.php`). Constructor stores the `linkchecker_summary_mail.settings` immutable config, the **`linkcheckerlink`** entity storage (from `entity_type.manager`), language manager, logger channel, mail manager, state, and the `datetime.time` service. Constants: `DAY = 60*60*24`, `LAST_CHECKED_STATE_KEY = 'linkchecker_summary_mail.last_checked'`.

## runCronCheck() — called from hook_cron

`linkchecker_summary_mail_cron()` (`.module`) resolves the service and calls this.

1. Reads state `linkchecker_summary_mail.last_checked` (default `FALSE`).
2. Computes `$time_ago` from `interval`: `now - DAY` for `daily`, `now - 7*DAY` for `weekly` (uses `time->getRequestTime()`). Any other interval value leaves `$time_ago = NULL`.
3. If `last_checked <= $time_ago` (the window has elapsed): when `summarize_all` is TRUE it sets `$last_checked = FALSE` (dropping the "new since" filter), calls `buildSummaryMail(interval, last_checked)`, then writes `last_checked = now`.

Because a fresh install has `last_checked = FALSE` and `FALSE <= <timestamp>` is true, the first qualifying cron run sends immediately.

## buildSummaryMail(string $interval, $last_checked) (protected)

- Logs the period, then builds an entity query on `linkcheckerlink`: `fail_count > 0` AND `status = 1` AND `code <> 200`; plus `last_check > $last_checked` unless `$last_checked === FALSE` (summarize-all or first run). Calls `accessCheck()` then `execute()`.
- Logs the count; **returns early if empty** (no mail on a clean site).
- `loadMultiple()`s the matching links, then dispatches based on the three recipient toggles:
  - `enable_global === TRUE` -> one `mail()` with **all** links to `mail_address`.
  - `notify_author === TRUE` -> loop links, one `mail()` **per link** to `$link->getParentEntity()->getOwner()->getEmail()`.
  - `notify_latest_editor === TRUE` -> loop links, one `mail()` **per link** to `$link->getParentEntity()->getRevisionUser()->getEmail()`.
- Every send goes through `plugin.manager.mail` with module `linkchecker_summary_mail`, key `summary`, langcode = site default language, and `params = ['period' => $interval, 'links' => ...]`.

## hook_mail($key, &$message, $params) (key summary, in .module)

- **Subject**: `t('Broken links found in the last @period on @site', ...)` where `@site` is `system.site` name and `@period` is `LinkcheckerSummaryMailInterval::periodToString($params['period'])` (`daily`->"day", `weekly`->"week"; `src/LinkcheckerSummaryMailInterval.php`).
- **Body**: one `<p>` per link via `FormattableMarkup`, text built with `t()`: "The link (anchor to @link) found on (anchor to @url) gives status code @code. This link has been checked a total of @num." — `@link` = `$link->getUrl()`, `@url` = the parent entity canonical absolute URL (or `''` if it has no `canonical` link template), `@code` = `$link->getStatusCode()`, `@num` = `formatPlural($link->getFailCount(), ...)`. Placeholders are escaped by `t()` / `FormattableMarkup`.

## Operational caveats (not security)

- `notify_author` / `notify_latest_editor` chain `getParentEntity()->getOwner()` / `->getRevisionUser()` with no null guard; a link whose parent entity or user reference is missing would error during that cron send. Global-only mode avoids that path.
- One mail per broken link in author/editor modes: a large backlog with those toggles on plus `summarize_all` can generate a lot of mail on the first run — clear or limit before enabling.
- Scheduling state is `linkchecker_summary_mail.last_checked` (State API). Reset via `drush sdel linkchecker_summary_mail.last_checked` to force a resend on the next cron.
