# Symfony Mailer Queue — manual setup guide

**Symfony Mailer Queue** (`symfony_mailer_queue`) makes the
[Symfony Mailer](https://www.drupal.org/project/symfony_mailer) module send email
**asynchronously**. Instead of delivering a message inline during the web
request, it puts the message on a Drupal queue and a queue worker delivers it
later (on cron), with configurable retry behaviour when a send fails.

The problem it solves is that sending mail during a request is slow and fragile:
an unreachable SMTP server can turn an ordinary node save into a failed request.
By moving delivery onto Drupal's queue, web requests stay fast and a temporary
mail outage no longer breaks the user's action — the mail simply waits and is
retried. It works out of the box with Drupal's built-in database queue, so no
extra infrastructure is required, though you can point it at another
Drupal-supported queue backend if you have one.

Crucially, queueing is a **per-policy decision**, not a global switch — so the
module does *not* change anything just by being enabled. You turn queueing on by
attaching its **Queue sending** email adjuster to whichever Symfony Mailer
policies you want queued, leaving other policies to send inline. It depends only
on the `symfony_mailer` module, adds no permissions, routes or Drush commands of
its own, and supports Drupal 10.3 and 11. For developers, it also dispatches
`EmailSendFailureEvent` and `EmailSendRequeueEvent` so other modules can log or
react when a delivery fails or is retried.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — attach the Queue sending adjuster to
   a mailer policy and tune its retry behaviour, plus notes on running the queue
   on cron.

## How to use it

The feature surfaces as an **email adjuster** in Symfony Mailer's policy system,
under **Configuration → System → Mailer** (`/admin/config/system/mailer`). You
edit (or add) a mailer policy, add the **Queue sending** adjuster to it, and from
then on mail matching that policy is queued rather than sent inline. The queued
mail is then delivered whenever the `symfony_mailer_queue` queue is processed —
typically on cron. See [Configuration](configuration/index.md) for the details.
