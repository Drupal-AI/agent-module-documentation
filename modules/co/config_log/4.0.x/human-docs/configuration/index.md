# Configuration

All of Configuration Log's behavior is controlled from one settings form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Development → Configuration Log**, or navigate directly
   to `/admin/config/development/config_log`.

## Destinations — where the log goes

Tick any combination of the three destinations:

- **Custom database table** — writes a row to the `config_log` table, storing the
  operation, the acting user, the config name, and the full YAML of both the new
  and the original data. This is the default and the source for the Views report.
- **Default logger (watchdog / dblog)** — sends each change to Drupal's logging
  system so it appears in *Reports → Recent log messages*.
- **Email** — sends a notification email for each change.

A destination only records when its box is ticked.

## Email settings

These apply when the **Email** destination is on:

- **Email address** — the recipient for change notifications.
- **Email subject** — the subject line. You can use the placeholders `@site`,
  `@id`, `@config_name`, and `@time`. The default is `[@site] Configuration
  change`.
- **Email body** — the message body. Supports the placeholders above plus
  `@changes` (the generated diff). The default is `User ID: @id<br />@changes`.

## Retention (database table)

- **Logs to keep** — the maximum number of rows to retain in the `config_log`
  table. `0` (the default) means keep everything; the form also offers 100, 1,000,
  10,000, 100,000, and 1,000,000. Cron trims older rows down to this limit in
  batches. This setting only has an effect when the database destination is
  enabled.

## Ignore list — filtering noisy config

- **Ignored config** — a list of config names or glob patterns to skip. `*` is a
  wildcard and a pattern must match the whole config name — for example `user.*`,
  `system.*`, or `*.settings`. Use this to silence chatty objects you do not care
  about.
- **Negate the ignore list** — inverts the meaning: instead of ignoring the
  matches, the log records **only** the matches. Turn this on to watch a specific
  whitelist — for example set the list to `user.settings` and negate it to log
  only changes to that one object.

## Import and no-op handling

- **Ignore config import** — when on, changes made during a configuration import
  (such as a deployment) are not logged, which keeps deployment noise out of the
  audit trail.
- **Ignore saves with no changes** — when on, a save that did not actually change
  any value is skipped.

## Secret redaction

- **Redact sensitive config values** — on by default. Before storing or sending
  anything, the module replaces likely-secret values (passwords, API keys, tokens,
  client secrets, SMTP passwords, and similar) with `[redacted]`. Only the
  matching value is redacted; sibling values stay visible. Leave this on unless you
  have a specific reason to capture raw secrets (not recommended).

## Diff context lines

- **Leading context lines** / **Trailing context lines** — how many unchanged
  lines to show before and after each change in the diff (0–50, default 0). These
  are used by the Config Log Views diff field to give a change some surrounding
  context.

## Save

Click **Save configuration**. Changes take effect immediately for subsequent
config changes. If you enabled the Config Log Views submodule, browse the log at
**Reports → Configuration log** (`/admin/reports/config-log`).

## Extending it (optional)

Configuration Log has no plugin system, but a developer can add a new destination
(for example Slack or syslog) by writing an event subscriber on the same config
events — see the [`agent/`](../../agent/extend/custom-destination.md) docs.
