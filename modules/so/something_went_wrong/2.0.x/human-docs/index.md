# Something Went Wrong — manual setup guide

**Something Went Wrong** (`something_went_wrong`) catches the exceptions and
errors Drupal throws and notifies your team about them — over **Slack** or by
**email** — so a developer hears about a problem promptly instead of a client
being the first to report it.

Drupal deliberately throws exceptions when code goes wrong, which halts the
request. That is useful during development because it makes problems obvious, but
it is far from ideal for visitors on a live site. This module bridges the two
concerns: it captures the error and pushes a notification out to the destination
you choose, so you can react before the issue spreads. It is a developer/ops
monitoring tool in the "Development" package; it works once you have told it where
to send notifications, and it has no dependencies on other contrib modules.

**A word on what those notifications contain.** Exception reports can include
stack traces, request data and other potentially sensitive details, and they are
sent **outside your site** to Slack or an email inbox. So point them at a
**trusted, access-controlled** destination, treat any Slack webhook URL as a
secret (store it in an environment variable, never commit it), and consider what
you are willing to have leave the server — redacting sensitive values where you
can. The module plays no access-control role of its own. Also note this release is
an **alpha**, so weigh that before relying on it in production.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

After enabling the module, set up your notification destination — a Slack channel
(via a Slack webhook URL) and/or an email address — so that when Drupal throws an
exception, an alert is delivered there. Choose a destination only trusted people
can read, since the alerts may carry sensitive diagnostic detail.
