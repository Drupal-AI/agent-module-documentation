# Avoid sending mail — manual setup guide

**Avoid sending mail** (`asm`) stops your site from sending email to addresses on
a **blocklist** you configure. Its main job is to keep a non‑production site from
accidentally emailing real people: on a staging or development copy of a site,
form submissions, order confirmations, and account notifications can all fire off
real messages to real addresses unless something intercepts them. This module is
that interceptor.

You give it a list of addresses (or address patterns) that should never receive
mail, and outbound messages to those addresses are suppressed. That makes it handy
in two situations: guarding a staging/dev environment so it can't email your
actual users, and quietly suppressing mail to a specific problematic address on
any environment.

Managing the blocklist is gated by the **Administer asm email blocked**
permission, so only trusted administrators can change what gets suppressed. This
is an operations/development tool with no content role of its own. It depends on
core's **Text** module and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — build the list of blocked
   addresses.

## Where it lives in the admin menu

The module's settings — where you manage the list of blocked addresses — are
available to users with the **Administer asm email blocked** permission. Grant
that permission only to trusted administrators, since it controls which recipients
your site is prevented from emailing. See [Configuration](configuration/index.md).
