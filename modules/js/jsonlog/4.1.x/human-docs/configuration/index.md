# Configuration

JSON Log has no settings page of its own. Its options are added as a **JSON Log**
section on core's **Logging and errors** form.

## Open the settings

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Logging and errors**, or navigate directly
   to `/admin/config/development/logging`.
3. Scroll to the **JSON Log** fieldset.

Settings are saved into the `jsonlog.settings` config object. There is no
module‑specific permission or Drush command.

## Settings, field by field

- **Severity threshold** (`jsonlog_severity_threshold`, default **4 = Warning**) —
  only events at or above this RFC severity are logged. Lower numbers are more
  severe, so raising the threshold logs *fewer*, more serious events and lowering
  it captures more (down to notice/debug). Emergency (0) is not a valid threshold.
- **Channels** (`jsonlog_channels`, default empty) — a comma‑separated whitelist of
  log channels (for example `php`, `cron`, a custom module). Empty means all
  channels are logged.
- **Truncate (Kb)** (`jsonlog_truncate`, default **64**) — the maximum message size
  in kilobytes; `0` disables truncation. The default is sized to stay within a
  filesystem block so concurrent writes don't get garbled.
- **Site ID** (`jsonlog_siteid`, default derived) — an identifier stamped on every
  entry so logs from multiple environments are distinguishable. If left blank it is
  derived from the hostname plus the database name.
- **Canonical** (`jsonlog_canonical`, default empty) — a stable name shared across
  load‑balanced instances of the same site, so their logs group together.
- **Log to stdout** (`jsonlog_stdout`, default **off**) — when on, entries are
  written to `php://stdout` instead of a file. Turn this on for Docker / Kubernetes
  so the platform collects the container's output.
- **File rotation** (`jsonlog_file_time`, default **`Ymd` = daily**) — how often a
  new file is started: `none` (one file forever), `Ymd` (daily), `YW` (weekly), or
  `Ym` (monthly).
- **Log directory** (`jsonlog_dir`, default derived) — the directory for the log
  file. If blank it is derived from PHP's `error_log` path (or a common Apache log
  dir) plus `/drupal-jsonlog`. The final file path is
  `{directory}/{site_id}[.{date}].json.log`. **The web server user must be able to
  write here** — the README suggests creating a `drupal-jsonlog` subdirectory and
  giving the web user ownership.
- **Prepend newline** (`jsonlog_newline_prepend`, default **off**) — a legacy option
  that prepends rather than appends the newline for each entry, for older pipelines.
- **Tags** (`jsonlog_tags`, default empty) — comma‑separated tags (for example
  `prod`, `web01`) added to every entry for downstream filtering.

## Environment‑variable overrides

Every setting above can be overridden by an environment variable named
`drupal_<setting>` — for example `drupal_jsonlog_dir`, `drupal_jsonlog_stdout`,
`drupal_jsonlog_severity_threshold`, or `drupal_jsonlog_siteid`. When set, the
environment value **wins over the stored config**, and the matching field on the
form is greyed out and marked as overridden. This is the recommended way to give
each environment (dev / staging / prod, or each container) its own settings without
editing site config.

Two notes:

- **Tags are combined**, not replaced — tags from the environment are merged with
  tags from config.
- Environment variables set in a vhost or `.htaccess` are **not** visible to Drush /
  CLI. If you want CLI‑triggered logging (like cron via Drush) to honor them, set
  them somewhere the CLI sees, such as `/etc/environment`.

## Verify it works

After saving, tick **Log test entry** on the form and save again. JSON Log writes a
sample entry and the confirmation message shows the target file path — the quickest
way to confirm the directory exists and is writable. If a write fails, the module
falls back to PHP's `error_log()`.

The JSON logger runs in addition to core's database log, so enabling it does not
turn off the regular *Reports → Recent log messages* view.
