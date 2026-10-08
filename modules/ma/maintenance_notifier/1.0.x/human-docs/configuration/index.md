# Configuration

The settings form is where you decide *when* an alert fires, *who* gets it, and
*what it says*.

## Open the settings form

1. Log in as an administrator.
2. Open the **Maintenance Notifier** settings form under **Configuration**.

## Notification threshold

Set the **time threshold in minutes** that the site must remain in maintenance
mode before an email is sent. A small value warns you quickly; a larger value
avoids alerts for routine, short deployments. The threshold is measured against
how long maintenance mode has been continuously on.

## Recipients

Choose who should be notified. You can:

- Enter a **comma-separated list of email addresses** — good for an ops mailbox
  or a couple of named administrators, and/or
- Select one or more **roles** — everyone holding those roles is notified.

Keep the recipient list to people who actually need to act on the alert.

## Email subject and body

Customise the message:

- **Subject** — the alert email's subject line.
- **Body** — the message text.

Both support **tokens**, so you can insert dynamic values (for example the site
name, or the current date) that are filled in when the email is sent. Use the
**token browser** on the form to find and insert the tokens you want.

## How the check runs

The module evaluates the threshold on **every cron run**, so make sure cron is
running regularly. To check immediately without waiting for cron, run the Drush
command `drush maintenance-notifier:check` (short alias `drush mnc`).

## Save

Click **Save configuration**. From then on, whenever the site stays in
maintenance mode past your threshold, the configured recipients receive the
alert.
