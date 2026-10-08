# Configuration

Getting Mailer Plus log working takes two steps: make sure the master switch is on,
and add the "Log email" adjuster to the Mailer policy for the mail you want to record.
This page covers both, plus the retention settings and the permissions.

## Two things must be true to log an email

1. The global **Enable logging** switch is on (it is on by default).
2. The **"Log email"** adjuster is present on the Mailer policy that handles the
   email.

If either is missing, nothing is logged.

## The settings form

Go to **Configuration → System → Mailer**, then the **Mailer Plus log** settings tab
(`/admin/config/system/mailer/symfony_mailer_log/settings`). This form is gated by the
core **Administer site configuration** permission. It controls the
`symfony_mailer_log.settings` config object:

- **Enable logging** — the master on/off switch for all logging. Default **on**. Turn
  it off to stop logging site-wide without editing any of your Mailer policies.
- **Maximum age** (`log_expiry.max_age`) — how long entries are kept before being
  deleted on cron, written as an **ISO 8601 duration**. For example `PT12H` (12
  hours), `P1D` (one day), `P1W` (one week), `P1M` (one month), or `P1Y` (one year).
  Leave it empty to keep entries forever. The value is validated as a proper duration.
- **Batch size** (`log_expiry.batch_size`) — the most entries to delete in a single
  cron run (minimum 1, default 100). This stops a big purge from overloading one cron
  run on a high-volume site. Leave it empty to delete all expired entries at once.

Expiry is enforced on **cron**: each run deletes the oldest entries whose logged date
is older than *now minus the maximum age*, up to the batch size. If maximum age is
empty, nothing is ever purged.

You can also read and set these from the command line:

```bash
drush cget symfony_mailer_log.settings
drush cset symfony_mailer_log.settings enable true -y
drush cset symfony_mailer_log.settings log_expiry.max_age P1W -y
drush cset symfony_mailer_log.settings log_expiry.batch_size 50 -y
```

## Turn logging on for a Mailer policy

Which emails actually get logged is decided by Symfony Mailer's **policy** system, not
by a key on the settings form:

1. Go to **Configuration → System → Mailer** (`/admin/config/system/mailer`) to see
   the Mailer / Mailer Plus policies.
2. Edit a policy — either a specific mail type (to log just that kind of email), or
   the catch-all **`*All*`** policy (to log everything).
3. Add the **"Log email"** adjuster element to the policy and save.

The adjuster itself has no options of its own — its little config form only links back
to the settings page above. Two variants ship (`LogMail` for Symfony Mailer 1.x and
`LogMailV2` for Mailer Plus 2.x) and the right one is selected automatically for your
installed version. The log entity is created just after the email is rendered, and any
send error is written into the entry afterward.

## Viewing logged mail

Logged emails appear at **Reports → Mail log**
(`/admin/reports/symfony_mailer_log`). Click any entry to inspect its full detail —
subject, addresses, the HTML and plain-text bodies, headers, the theme used, the
transport, the linked user account, and any recorded send error. You can delete an
individual entry from its page.

## Uninstall behavior

Uninstalling the module cleans up after itself: it strips the "Log email" adjuster
from every Mailer policy's configuration and removes the logged entries. Keep that in
mind if the log is serving as a compliance trail.

## Permissions

Grant these at **People → Permissions**:

- **View symfony mailer log entries** (`view symfony mailer log entries`) — view
  logged emails. Because entries can contain full email bodies and recipient
  addresses, treat this as **sensitive** and grant it only to trusted roles (e.g.
  support staff who need it).
- **Delete symfony mailer log entries** (`delete symfony mailer log entries`) — delete
  individual entries.
- **Administer symfony mailer entity log entries** (`administer symfony mailer entity
  log entries`) — full administration of the log entity, including manage-display
  screens.

Note that the **settings form** itself is gated separately by the core **Administer
site configuration** permission, not by any of the three above.
