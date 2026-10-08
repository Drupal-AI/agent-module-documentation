<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link Checker Summary Mail (linkchecker_summary_mail) — agent index

Emails a **periodic (daily/weekly) digest** of broken links that the **Link Checker** module has
recorded. No entities, plugins, permissions, or Drush of its own — it queries Link Checker's
`linkcheckerlink` entities on cron and hands the results to the core mail manager.

- Version **2.0.0-beta4** (version-dir `2.0.x`). Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.
- Depends on **`linkchecker`** (`drupal/linkchecker ^1.0@beta || ^2.0@alpha`). Package: none.

- **Settings form, config object + schema, defaults, recipients, cron/state behaviour** →
  [config/settings.md](config/settings.md)
- **The cron check, the entity query, and how the mail body is built (`hook_mail`)** →
  [api/summary-builder.md](api/summary-builder.md)

## What it actually provides (from source)

- **One service** `linkchecker_summary_mail.summary_builder` →
  `Drupal\linkchecker_summary_mail\LinkcheckerSummaryMailSummaryBuilder`
  (args: `config.factory`, `entity_type.manager`, `language_manager`, its logger channel,
  `plugin.manager.mail`, `state`, `datetime.time`). Plus a `logger.channel.linkchecker_summary_mail`.
- **One config form** `Form\LinkcheckerSummaryMailConfigForm` at route
  **`linkchecker_summary_mail.settings`** → `admin/config/content/linkchecker/summary_mail`,
  requirement **`_permission: 'administer linkchecker'`** (Link Checker's own permission — this
  module defines none). Exposed as a local task + menu link under Link Checker's settings.
- **Hooks** (`.module`): `hook_help`, `hook_cron` (calls `$builder->runCronCheck()`),
  `hook_mail` (key `summary` — builds subject + one body paragraph per link).
- **Config**: object `linkchecker_summary_mail.settings` with schema in
  `config/schema/linkchecker_summary_mail.schema.yml`; install defaults in `config/install/`.
  `hook_install` seeds `mail_address` from `system.site` mail;
  a post_update sets `notify_latest_editor` default FALSE.
- **Helper** `LinkcheckerSummaryMailInterval` (abstract): constants `DAILY`='daily',
  `WEEKLY`='weekly', and `periodToString()` for the subject line.
- No new entity types, no field/formatter/plugin types, no REST routes, no library assets.

## Mechanism in one paragraph

`hook_cron` → `runCronCheck()` compares the `linkchecker_summary_mail.last_checked` **state** key
against now-minus-interval; if due it calls `buildSummaryMail()`, which runs a `linkcheckerlink`
entity query (`fail_count > 0`, `status = 1`, `code <> 200`, and `last_check > last_checked` unless
"summarize all"), then sends via `plugin.manager.mail` to the global address (if `enable_global`),
each link's parent-entity owner (if `notify_author`), and/or each parent-entity revision user (if
`notify_latest_editor`). Recipients come from admin config or Drupal user emails; the body embeds
the link URL, the page URL, status code and fail count through escaped `t()`/`FormattableMarkup`
placeholders.
