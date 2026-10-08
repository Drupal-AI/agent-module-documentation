# Error Squelch — manual setup guide

**Error Squelch** (`error_squelch`) hides Drupal **status, warning and error
messages** whose text matches patterns you configure. It's the answer to
persistent, known-benign message noise — a payment gateway's hardcoded "running in
test mode" notice, missing-file warnings during an in-progress media sync, or chatty
contrib modules with unhelpful defaults — that clutters screenshots, training
videos and on-call dashboards.

It works by filtering the list of messages just before the status-messages template
renders, comparing each message against your list of patterns. A match can be a
simple **case-insensitive substring** (the default) or a full **PHP regular
expression** with delimiters. Matched messages are removed from the display.

One thing to be clear about: suppression is **purely cosmetic**. Error Squelch hides
the message, but it does not fix whatever condition produced it — so use it to quiet
noise you understand while a proper fix is pending, not as a way to make real
problems disappear. To help you stay honest about that, it can optionally **log**
every suppressed message to its own channel for an audit trail, and it has a **test
mode** that injects a known message so you can confirm your patterns work before
deploying them.

It supports Drupal 10.3+ and 11, needs no other modules, and offers Drush commands
for managing patterns from the command line.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the pattern list, logging, test mode,
   and the Drush commands.

## Where it lives in the admin menu

Error Squelch adds a settings form for its pattern list, reachable via the module's
**Configure** link on the Extend page. Access to it is gated by the **Administer
Error Squelch** permission.
