# Scheduler Request Cron — manual setup guide

**Scheduler Request Cron** (`scheduler_request_cron`) makes the
[Scheduler](https://www.drupal.org/project/scheduler) module act more promptly by
running Scheduler's lightweight cron during normal page requests, instead of
waiting for the site's next full cron run. If your content is scheduled to
publish at 9:00 but your full cron only runs every hour, the content might not
appear until much later; with this module, the scheduled publish/unpublish
actions are picked up on the next page request after the due time (subject to a
minimum interval you set), so timing feels much closer to what editors expect.

The scheduled actions run with the site's own privileges, exactly the way cron
runs them — this module has no access-control role of its own. Its one trade-off
is that it adds a small amount of work to page requests (running Scheduler's
lightweight cron), so you set a sensible minimum interval to keep that overhead
low. It depends on the Scheduler module and works on Drupal 10 and 11.

The module does need a quick visit to its settings form to choose how often the
request-based cron may fire and whether to log each run. Sensible defaults are
provided (every 5 minutes, logging off), so it will work as soon as it is enabled.

This guide is written for a **human** setting things up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Scheduler.
2. [Configuration](configuration/index.md) — set the minimum interval between
   runs and turn logging on or off.

## Where it lives in the admin menu

The module's settings are stored in the `scheduler_request_cron.settings`
configuration. See [Configuration](configuration/index.md) for the two options
and how to reach the form.
