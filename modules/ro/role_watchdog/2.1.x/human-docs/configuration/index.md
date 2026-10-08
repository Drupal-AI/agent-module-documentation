# Configuration

Role Watchdog logs every role change out of the box — **no configuration is
required for the audit trail to work**. This settings form only controls two
optional extras: mirroring changes into Drupal's standard log, and email
notifications.

## Open the settings form

1. Log in as a user with the **Administer Role Watchdog**
   (`administer role_watchdog`) permission.
2. Go to **Configuration → People → Role Watchdog**, or navigate directly to
   `/admin/config/people/role_watchdog`.

The values are saved to the `role_watchdog.settings` configuration object.

## Also log to the Drupal log (dblog/syslog)

- **Log role changes to the standard log** (`role_watchdog_use_watchdog`) —
  **on by default**. When ticked, each role change is written to Drupal's PSR‑3
  logger (on the `role_watchdog` channel) *in addition to* the module's own audit
  entity, so the change shows up in Reports → Recent log messages (dblog) or
  whatever central logging you use. Untick it if you'd rather rely solely on the
  module's own log.

## Email notifications

- **Monitor roles** (`role_watchdog_monitor_roles`) — the set of roles you care
  about for notifications. The default install watches the **Administrator** role.
- **Notify email** (`role_watchdog_notify_email`) — the address that receives a
  notification when a role change happens. **This is the important one to check:**
  the module installs with a placeholder value of `email@example.com`, which is
  non‑empty, so notifications will attempt to send there until you change or clear
  it. Enter a real address (a shared security/audit distribution list works well),
  or empty the field to switch notifications off entirely — notifications only
  send when this field is non‑empty.

Notification emails are sent from your site email address with a subject like
"Role watchdog notification on *(your site)*".

## Save

Click **Save configuration**. You can also set these from the command line:

```bash
drush config:set role_watchdog.settings role_watchdog_use_watchdog 1 -y
drush config:set role_watchdog.settings role_watchdog_notify_email 'audit@example.com' -y
```

## Reading the audit trail

- Each user account has a **Role history** tab showing that person's role changes.
- The module ships several Views for browsing the log site‑wide. Grant the
  **Access Role Watchdog reports** (`access role_watchdog reports`) permission to
  the roles who should be able to view them.
