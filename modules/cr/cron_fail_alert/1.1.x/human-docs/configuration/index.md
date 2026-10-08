# Configuration

Cron Fail Alert works with sensible defaults, so this form is about tuning it to
your site rather than making it function. The settings decide how closely the
module watches cron and who hears about it when something goes wrong.

## Open the settings form

1. Log in as a user with the module's administration permission (an administrator by
   default).
2. Go to **Configuration → System → Cron → Cron Fail Alert settings**, or navigate
   directly to `/admin/config/system/cron-fail-alert`.

The form is organized into two sections: monitoring and notifications.

## Monitoring settings

- **Check frequency** — how often the module verifies that cron is still running,
  in minutes (1–1440). The default is **15 minutes**. Running checks on a schedule
  rather than on every page load keeps the overhead low; a smaller value catches
  failures sooner at the cost of slightly more frequent checks.
- **Cron failure tolerance** — the maximum time allowed since the last successful
  cron run before the module considers cron to have failed, in minutes (1–10080,
  i.e. up to a week). The default is **20 minutes**. This must be **greater than the
  check frequency** — the module validates this for you to prevent false alerts.
  Set it comfortably above your real cron interval so a single late run doesn't
  trigger a warning.

## Email notification settings

- **Recipient email address** — where alert emails are sent. It defaults to the
  site email address. Point this at whoever should act on cron problems (a site
  administrator or an operations mailbox). Remember these messages can include
  operational detail about the site.
- **Subject line** — a customizable subject for the alert email.
- **Message body** — a customizable message template. It supports two tokens:
  `@minutes` (how long since cron last ran) and `:site` (your site name), so you can
  produce a clear, self-explanatory alert.

## Save

Click **Save configuration**. Monitoring continues in the background on your chosen
schedule, and if cron stalls beyond the tolerance you'll receive an email at the
address you set.
