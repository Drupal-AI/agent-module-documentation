# Configuration

Maillog starts logging mail as soon as it's enabled. The settings form is where you
control the two things that matter most on a dev or staging site — whether mail is
actually delivered, and how much of each message you keep.

## Open the settings form

1. Log in as a user with the **Administer Maillog** permission.
2. Go to **Configuration → Development → Maillog Settings**, or navigate directly
   to `/admin/config/development/maillog`.

The form also carries a **Clear all maillog entries** button, which takes you to a
confirmation page for wiping the log.

## The settings

All of these are stored in the `maillog.settings` config object.

- **Send mails** (`send`, default **on**) — when on, Maillog delivers email for
  real (via core's PHP mailer) after logging it. **Turn this off on dev/staging**
  to stop any mail reaching real recipients while still capturing it. When delivery
  is off, admins see a warning with a link back to this form.
- **Notify visitors that delivery is disabled** (`nosend_notify`, default off) —
  when on, non-admin visitors are told that mail delivery is currently turned off.
- **Log mails** (`log`, default **on**) — stores each outgoing email as a row in
  the `maillog` table. This is what populates the Reports → Maillog list. Leave it
  on unless you only want on-screen output.
- **Notify visitors that their mail was logged** (`log_notify`, default off) —
  shows visitors a message confirming their email was recorded.
- **Verbose** (`verbose`, default **on**) — prints the full contents of each mail
  on-screen as it's "sent." This is only ever shown to users who hold the **View
  Maillog** permission, so ordinary visitors never see mail contents even with
  verbose on.
- **Trim stored body** (`body_trimmed`, default off) — when on, only the first 512
  characters of the body are stored, keeping the database small.
- **Remove base64 data** (`base64_remove`, default off) — strips
  `data:...;base64,...` blobs (inline images/attachments) out of the stored body.

Click **Save configuration** to apply.

### Setting these from the command line

```bash
drush cget maillog.settings
drush cset maillog.settings send false -y        # stop delivering mail (dev/staging)
drush cset maillog.settings cron_enabled true -y
```

## Automatic cleanup on cron

To stop the log growing forever, turn on cron-based pruning:

- **Enable cron cleanup** (`cron_enabled`, default off) — when on, Maillog prunes
  old entries each time cron runs.
- **Keep limit type** (`keep_limit_type`) — choose how to prune:
  - **By age** (`time_to_keep`) — delete entries older than a number of **days**,
    set in **Time to keep**.
  - **By count** (`number_to_keep`) — keep only the newest N entries, set in
    **Number to keep**.

## Clearing the whole log

- From the UI: use the **Clear all maillog entries** button on the settings form
  and confirm.
- From the command line: `drush maillog:clear` truncates the `maillog` table and
  removes every stored message in one step (no arguments or options). Use the cron
  cleanup above instead if you want age- or count-based pruning rather than a full
  wipe.

## Permissions

Maillog defines three permissions, all marked security-sensitive because logged
mail can contain private data. Assign them at **People → Permissions**
(`/admin/people/permissions`):

- **View Maillog** (`view maillog`) — see the log list and message details at
  `/admin/reports/maillog`, and see the on-screen verbose mail dump.
- **Delete entries from the log** (`delete maillog`) — delete individual logged
  messages.
- **Administer Maillog** (`administer maillog`) — reach this settings form and the
  clear-all confirmation page.

Grant View Maillog to support staff who need read-only access to sent mail; keep
Administer Maillog to trusted admins only.

## Locking behavior per environment

To force Maillog's behavior for a specific environment regardless of the saved
config, add overrides to that environment's `settings.php`:

```php
$config['system.mail']['interface']['default'] = 'maillog';
$config['maillog.settings']['send'] = FALSE;   // don't deliver
$config['maillog.settings']['log'] = TRUE;     // but do log
```

This is a reliable way to guarantee a staging box never sends real email even if
someone changes the setting in the UI.
