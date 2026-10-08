# Configuration

Migration Notify needs configuring before it will send anything: you choose the
notification channel(s), who receives them, and how the checks are triggered. The
settings live in the `migration_notify.settings` configuration form.

## Open the settings form

1. Log in as a user with permission to administer the site's configuration (an
   administrator by default).
2. Open the Migration Notify settings form (`migration_notify.settings`).

## Notification channels

Migration Notify currently supports two channels, and you can use either or both:

- **Email** — sends the migration status notification to one or more email
  addresses. This relies on your site's normal mail configuration, so make sure
  Drupal can send mail.
- **Slack** — posts the notification into a Slack workspace. This needs a Slack
  incoming webhook (or token) for the channel you want to post to. Because that
  webhook is a secret, keep it out of version control — store it in an environment
  variable and reference it rather than pasting it into committed config where your
  setup allows.

## Recipients

Enter who should be notified — the email address(es) for the email channel and/or
the Slack destination for the Slack channel. Since the notifications can include
migration status detail, make sure the recipients are people who should see that
information.

## Triggers: instant vs cron

Choose how the status checks run:

- **Instant** — notifications are triggered as migrations run.
- **On cron** — the module checks migration status when cron runs, comparing each
  migration's current status against its last recorded state.

> **A caution about the cron heuristic.** Drupal migrations have no built-in
> "stuck" status. Migration Notify infers one: if the same migration is *not idle*
> between two checks, it treats it as possibly stuck. So if cron (or your check
> interval) runs more frequently than a migration can realistically complete, you
> may receive false-positive "stuck" alerts. Tune your cron frequency accordingly.

## Save

Save the form. From then on, when a migration completes, fails, or is flagged by
the status check, the configured recipients receive a notification on the channels
you enabled.
