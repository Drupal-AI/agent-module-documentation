<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — linkchecker_summary_mail.settings

## Install / enable

`composer require drupal/linkchecker_summary_mail` then `drush en linkchecker_summary_mail`.
Requires the **Link Checker** module (`linkchecker`) to be present and actually scanning links —
this module only reads what Link Checker has already recorded. `hook_install`
(`linkchecker_summary_mail_install`) seeds `mail_address` with the site email
(`system.site` → `mail`).

## Config object

Single config object **`linkchecker_summary_mail.settings`**. Schema:
`config/schema/linkchecker_summary_mail.schema.yml` (`type: config_object`). Install defaults:
`config/install/linkchecker_summary_mail.settings.yml`.

| Key | Type | Install default | Meaning |
|-----|------|-----------------|---------|
| `interval` | string | `daily` | Send cadence. One of `daily` / `weekly` (`LinkcheckerSummaryMailInterval` constants). |
| `enable_global` | boolean | `TRUE` | Send one digest to the single global address `mail_address`. |
| `mail_address` | string | `''` (install) / site mail (`hook_install`) | Recipient for the global digest. |
| `notify_author` | boolean | `FALSE` | Send each affected entity's **owner** their links. |
| `notify_latest_editor` | boolean | `FALSE` | Send each affected entity's **revision user** (latest editor) their links. |
| `summarize_all` | boolean | `FALSE` | If TRUE, every mail contains the **full** broken-link list; if FALSE, only links failed since the last send. |

Note `mail_address` has an empty install default but is set to `system.site` mail by
`hook_install`; the post_update `..._default_value_notify_latest_editor` backfills
`notify_latest_editor = FALSE` on sites upgraded from before that key existed.

## Settings form

`Form\LinkcheckerSummaryMailConfigForm` (`ConfigFormBase`, form id
`linkchecker_summary_mail_config_form`; `getEditableConfigNames()` →
`['linkchecker_summary_mail.settings']`).

- Route **`linkchecker_summary_mail.settings`** → `admin/config/content/linkchecker/summary_mail`,
  requirement **`_permission: 'administer linkchecker'`** (defined by the `linkchecker` module).
- Surfaced by `*.links.task.yml` (local tab "Summary mail") and `*.links.menu.yml` (menu link
  "Summary Mail"), both under Link Checker's `linkchecker.admin_settings_form`.
- Form elements: `interval` (select Daily/Weekly), `enable_global` (checkbox), `mail_address`
  (textfield, `#states` visible only when `enable_global` is checked), `notify_author`,
  `notify_latest_editor`, `summarize_all` (checkboxes). `submitForm()` writes all six keys.

## Operating notes

- Recipients are chosen independently: global, author, and latest-editor can all be on at once. If
  all three are off nothing is sent even when links are broken.
- `notify_author` / `notify_latest_editor` iterate the found links and send **one mail per link**
  to that entity's owner / revision user (see [../api/summary-builder.md](../api/summary-builder.md)).
- Scheduling is driven purely by cron and the `linkchecker_summary_mail.last_checked` **state** key
  (not config). To force the next cron run to resend, clear it:
  `drush sdel linkchecker_summary_mail.last_checked`.
- Delivery uses the core mail manager, so whatever mail transport (SMTP, Symfony Mailer, etc.) the
  site has configured handles the actual send.
