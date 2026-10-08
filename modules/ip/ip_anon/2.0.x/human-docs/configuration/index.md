# Configuration

IP Anonymize does nothing until you turn its policy on. Everything is set on one
short form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → People → IP address anonymization**, or navigate
   directly to `/admin/config/people/ip_anon`.

## Retention policy

This is the master switch. Pick one of:

- **Preserve IP addresses** *(default)* — nothing is scrubbed. Cron ignores the
  module entirely. Use this to keep the module installed but inactive, or to
  temporarily pause anonymization site-wide.
- **Anonymize IP addresses** — turn scrubbing on. From now on, each cron run will
  anonymize IPs that have passed their retention period in every table listed
  below.

## Retention period (one per table)

Below the policy switch, the form lists a **Retention period** dropdown for each
table it can scrub. Which tables appear depends on what's installed: the core
`sessions` table is always there, and additional rows show up for modules like
comment, Database Logging, Commerce, Login History, and Webform when those are
present.

For each table, choose how long an IP may be kept before it's scrubbed:

- A **time interval** (the options are standard Drupal durations — for example 1
  hour, 1 day, 1 week). Any row whose timestamp is older than *now minus this
  period* has its stored IP overwritten on the next cron run.
- **Forever** — never scrub this table. This is the default for every table, which
  is why enabling the module changes nothing until you pick real periods.

Set a short window on the data you care most about (session IPs are a common
choice) and leave others longer or on *Forever* as your policy requires.

## Save

Click **Save configuration**. With the policy set to *Anonymize* and at least one
table given a real retention period, the next cron run will start scrubbing.

## What scrubbing actually does

Anonymization is a **destructive, in-place** operation: the stored client
IP/hostname is overwritten with the string `0`, and the original value is **not
recoverable** afterwards. Counts, timestamps, and the rest of each record are left
intact — only the IP column is cleared. Rows that were already scrubbed are
skipped.

## Command-line control (Drush)

The module ships two Drush commands:

- **Scrub on demand** — run the same work cron does, immediately:

  ```bash
  drush ip_anon:scrub
  ```

  If the policy is set to *Preserve*, this command does nothing and warns you that
  IPs are being preserved. Handy after handling a specific data-deletion request.

- **Review the current policy** — print a table of every scrubbed table and its
  retention period (showing *Forever* where a table is never scrubbed):

  ```bash
  drush ip_anon:policy
  drush ip_anon:policy --format=json
  ```

## Setting the policy from the command line

You can configure it without the UI:

```bash
# turn anonymization on and keep session IPs for at most 1 hour (3600 seconds)
drush config:set ip_anon.settings policy 1 -y
drush config:set ip_anon.settings period_sessions 3600 -y
```

Retention periods are stored in seconds; a negative value (such as `-1`) means
*Forever*. The full policy lives in the `ip_anon.settings` configuration object, so
it exports and deploys with the rest of your configuration.
