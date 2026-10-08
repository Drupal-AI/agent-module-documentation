# Timeout Notification — manual setup guide

**Timeout Notification** (`timeout_notification`) warns logged-in users that their
Drupal session is about to expire, and offers them a way to refresh (extend) it
before they are logged out. A front-end library shows a notification a configurable
number of seconds before the session ends, so users filling in long forms get a
chance to act rather than being silently logged out and losing unsaved work.

It is most useful on editorial or membership sites where people spend a long time on
a single page — a content author drafting a long article, a member completing a
multi-step form. The warning and the refresh are driven client-side against the
real session, so the countdown reflects the session's actual lifetime and the
"keep me signed in" action genuinely extends it.

The session's total lifetime itself is a PHP/Drupal setting (`gc_maxlifetime` in
your `services.yml`), not something this module changes — Timeout Notification reads
that lifetime and warns ahead of it. What you configure in the module is how many
seconds in advance the warning appears (60 by default). The module has no
dependencies beyond core and works on Drupal 8.8 through 10.

One caveat worth acting on at setup time: the settings route is gated by a
permission named `configure_timeout_notification_settings`, so make sure that
permission is actually granted to your admin role, or the settings form will be
unreachable. Note also that this release is not covered by drupal.org's
security-advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the warning lead time and (if
   needed) align the session lifetime.

## Where it lives in the admin menu

The settings form is at `/admin/config/timeout_notification` (route
`timeout_notification.settings`), gated by the
`configure_timeout_notification_settings` permission.
