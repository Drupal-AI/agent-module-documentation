# Inactive User Management — manual setup guide

**Inactive User Management** (`inactive_user_management`) helps you keep a Drupal
site's user base tidy by watching for accounts that have gone dormant. When someone
hasn't logged in for longer than a period you configure, the module emails them a
notification — reminding them the account exists and nudging them to log back in.
Both the message text and the interval between notifications are easy to configure,
and the module is deliberately light.

In this release the module focuses on **notifications**. The maintainer's roadmap
adds later stages — automatically deactivating users after a set time, then
automatically deleting deactivated/blocked users after a further period, plus a
report page showing who was notified, blocked, and deleted and when. Because those
destructive stages are future work, today's version is safe to run without fear of
losing accounts; keep the roadmap in mind if you plan to lean on block/delete
behavior later.

The module runs on cron and sends its email through Drupal's Symfony Mailer. It
uses the **Ultimate Cron** module to control how often its job runs (out of the box,
once a day). After installing, you enable the inactive‑user notification in the
configuration and, ideally, write your own message.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside its dependencies.
2. [Configuration](configuration/index.md) — enable notifications, set the timing,
   customize the message, and tune the cron schedule.

## Where it lives in the admin menu

Once enabled, you turn on and tune the notifications from the module's settings
form under **Configuration**, and you set how often its job runs from **Ultimate
Cron** (under **Configuration → System → Cron jobs**). It defines its own
permission for administering that configuration.
