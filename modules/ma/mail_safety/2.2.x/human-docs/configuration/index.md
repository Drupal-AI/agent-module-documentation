# Configuration

Mail Safety is controlled by one settings form plus a dashboard for the emails it catches.
Remember the golden rule: **nothing is intercepted until the master switch is on and at
least one destination is selected.**

## Open the settings form

1. Log in as a user with the **Administer mail safety** permission.
2. Go to **Configuration → Development → Mail Safety**, then the **Settings** tab, or
   navigate directly to `/admin/config/development/mail_safety/settings`.

All values live in the config object **`mail_safety.settings`**.

## The settings, field by field

- **Enabled** (`enabled`, default off) — the master switch. When on, every outgoing message
  has its "send" flag set to false, so nothing is delivered the normal way. This is the
  toggle that makes Mail Safety active.
- **Send mail to dashboard** (`send_mail_to_dashboard`, default off) — when on, every caught
  mail is stored in the `mail_safety_dashboard` database table and shown on the dashboard,
  where you can read and resend it.
- **Send mail to default mail** (`send_mail_to_default_mail`, default off) — when on, the
  recipient of each caught mail is rewritten to the **default mail address** below, the
  Cc/Bcc headers are removed, and that single copy *is* delivered (its "send" flag is turned
  back on). Use this to funnel all mail to one safe inbox.
- **Default mail address** (`default_mail_address`, default empty) — the single address all
  mail is rerouted to when the option above is on (for example `qa@example.com`).
- **Log retention period** (`log_retention_period`, default "keep forever") — dashboard rows
  older than this are deleted automatically on cron. The form offers 1 hour, 6 hours, 12
  hours, 1 day, 1 week, 4 weeks, or 3 months; leaving it empty/0 keeps caught mail
  indefinitely.

**Important combinations:**

- To *stop and inspect* mail: turn **Enabled** on and **Send mail to dashboard** on.
- To *reroute* mail to a safe inbox: turn **Enabled** on, **Send mail to default mail** on,
  and set a **Default mail address**.
- You can enable both destinations at once — the mail is both stored and delivered to the
  safe address.
- If **Enabled** is on but **both** destinations are off, mail is silently dropped — stopped,
  but neither stored nor rerouted.

## Reading and setting values from the command line

```bash
# See the whole config object:
drush cget mail_safety.settings

# Stop mail and capture it to the dashboard:
drush cset mail_safety.settings enabled 1 -y
drush cset mail_safety.settings send_mail_to_dashboard 1 -y

# Reroute everything to one safe address instead:
drush cset mail_safety.settings send_mail_to_default_mail 1 -y
drush cset mail_safety.settings default_mail_address 'qa@example.com' -y

# Auto-purge dashboard rows older than one week (on cron):
drush cset mail_safety.settings log_retention_period 604800 -y
```

## The dashboard

The dashboard lives at **Configuration → Development → Mail Safety**
(`/admin/config/development/mail_safety`) and lists every caught email, newest first. For
each one you can:

- **View** it rendered with the site's configured mail theme, or view just the body.
- Open the **details** to inspect the full message array — headers, parameters, the sending
  module and key.
- **Resend to original** recipients (once you've finished testing), or **resend to default**
  address for a second look.
- **Delete** an individual message.

A **Clear** action empties the whole dashboard table at once. Captured mail also expires
automatically according to the **Log retention period** setting, cleaned up on each cron run.

## Permissions

Grant these at **People → Permissions** (both are marked as restricted):

- **`administer mail safety`** — required to reach the settings form and change how mail is
  handled.
- **`use mail safety dashboard`** — required to open the dashboard and use its per‑mail
  actions (view, resend, delete, clear).

Splitting these lets you give testers dashboard access without allowing them to change the
mail settings.
