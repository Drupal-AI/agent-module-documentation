# Configuration Log — manual setup guide

**Configuration Log** (`config_log`) keeps a record of every configuration change
on your site — creates, updates, renames, deletes, and config imports — so you
always have an audit trail of *who* changed *what* and *when*. For each change it
can store the full before-and-after YAML, so you can reconstruct a diff later or
even recover the previous state of a config object.

You choose where the log goes. Three independent **destinations** can be toggled
on the settings form: a dedicated **database table** (`config_log`), Drupal's
standard **logging system** (so changes appear in *Reports → Recent log
messages*), and **email notifications** to an address you specify. You can also
filter out noisy config objects with a glob-based ignore list, invert that list to
log only a specific whitelist, skip changes made during a config import, and cap
the table to a maximum number of rows that cron prunes automatically.

Security is handled by default: before writing anything, Configuration Log
**redacts likely secrets** — passwords, API keys, tokens, client secrets, SMTP
passwords — replacing just the sensitive value with `[redacted]` while leaving the
rest of the object readable. The optional **Config Log Views** submodule adds a
ready-made report at `/admin/reports/config-log` with an inline From/To diff.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including how the event
subscribers and the database table work — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and turn on the optional Views report.
2. [Configuration](configuration/index.md) — the destinations, ignore list,
   retention, redaction, and email settings, field by field.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → Configuration Log**
(`/admin/config/development/config_log`), which requires the *Administer site
configuration* permission. If you enable the Config Log Views submodule, the
report lives at **Reports → Configuration log** (`/admin/reports/config-log`).
