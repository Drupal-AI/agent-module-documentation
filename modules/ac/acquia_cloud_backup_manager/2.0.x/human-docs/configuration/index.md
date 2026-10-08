# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → Acquia Cloud → Backup Manager**
   (`/admin/config/services/acquia-cloud/backup-manager`).

## Credentials — supply them as environment variables

This is the most important choice on the page, so get it right.

The module can read the Acquia Cloud API token and secret in two ways, and **only
one is safe**. When both values are present as **environment variables**, the module
uses them and the settings form **hides the credential fields entirely**, telling
you on screen that they are set globally. That is the configuration to use. Acquia
Cloud provides environment variables natively, and this module is only useful on
Acquia Cloud, so there is no reason to use the other path.

Set the two environment variables (the API token and the API secret) on your Acquia
Cloud environment, then load the settings form — the credential fields should be
gone.

### Do not fill the credential fields into the form

If you type the token and secret into the form instead, both are stored in plain
module configuration. That has two consequences worth spelling out:

- **They end up in git.** A configuration export writes both values, in clear, into
  the config sync directory — which on nearly every project is committed and pushed.
  They then live in every clone, every CI checkout, and the history forever. They
  are also in every database dump.
- **They are shown back in the page.** The fields render the stored values in clear
  (as plain text fields, not masked password fields), so the secret appears in the
  settings page HTML — visible to a screenshot, a screen-share, a proxy, or anything
  else that sees the response.

Remember these credentials control environments, databases, deployments and
environment variables for the **entire application**, not just this site. Set the
environment variables and leave the form fields blank.

## Target application and environment

Choose the Acquia Cloud **application** and **environment** whose on-demand backups
this policy should manage.

## Retention rule

Pick how many on-demand backups to keep:

- **Keep for N days** — delete on-demand backups older than the number of days you
  set.
- **Keep the newest N** — retain a fixed number of the most recent on-demand backups
  and delete the rest.

Only manual / on-demand backups are managed here; Acquia's scheduled backups are not
touched.

## Enable cron deletion

Deletion is **opt-in**. Turn on the cron option (`cron_enabled`) when you are
confident in your retention rule — from then on, each cron run prunes the on-demand
backups that have aged out. Review your retention setting before enabling it, since
the pruning is automatic once it is on.

## Save

Click **Save configuration**. With credentials supplied via environment variables, a
retention rule chosen, and cron enabled, the module keeps your on-demand backups
trimmed automatically.
