# Configuration

Config Notify does nothing until you tell it *how* to notify you and *when* to check.
This page walks through both.

## Open the settings form

1. Log in as a user with the **Synchronize configuration** permission (an administrator by
   default). This is the same permission that governs configuration import/export, which is
   the appropriate audience for drift alerts.
2. Go to **Configuration → Development → Configuration synchronization → Notify**, or
   navigate directly to `/admin/config/development/configuration/notify`.

## Choose a notification channel

Config Notify supports two channels, and you can use either or both:

- **Email** — sends the drift notification to one or more recipient addresses. This relies
  on your site's normal mail delivery, so make sure Drupal can actually send mail (core's
  mail system, or a module such as SMTP / Symfony Mailer) before you count on it.
- **Slack** — posts the notification into a Slack channel. This works through a Slack
  **incoming webhook** URL, which you generate in your Slack workspace's app settings and
  paste into the form. Treat that webhook URL as a secret: anyone holding it can post to
  your channel.

Fill in the recipient address(es) and/or the Slack webhook for whichever channel you want,
then save.

## Immediate vs. cron notifications

Notifications can be sent **immediately** or **via cron**. In practice, the useful pattern
is to let the check run **on cron** so drift is caught automatically on a schedule, rather
than only when someone happens to open this form. A check that depends on a human
remembering to run it is a check that surfaces problems on deploy day. Make sure cron is
running regularly on the site (via `drush cron`, a system crontab, or your hosting
platform's scheduler).

## Tune out the baseline noise

Almost every real site carries a little *expected* drift — modules that write configuration
at runtime, and anything you deliberately exclude from exports with
[`config_ignore`](https://www.drupal.org/project/config_ignore) or
[`config_split`](https://www.drupal.org/project/config_split). If Config Notify reports
drift on every run because of that baseline, people quickly learn to ignore it. Spend a
little time getting your ignore/split rules right so that a notification from Config Notify
means a *real*, unexpected change — that is what makes the alerts worth reading.

## Save

Click **Save configuration**. From then on, whenever the active configuration diverges from
your exported configuration, Config Notify will alert your chosen channel(s) on the schedule
you set.
