# Private Message Flood — manual setup guide

**Private Message Flood** (`private_message_flood`) adds **flood (rate-limit)
protection** to the [Private Message](https://www.drupal.org/project/private_message)
module. It limits how many messages — and how many new threads — a user may send
within a time window, and it lets you set those limits **per role**, so you can
curb messaging spam and abuse without getting in the way of trusted members.

The time windows are true durations rather than fixed minutes: the module uses
the [Duration Field](https://www.drupal.org/project/duration_field) module, so a
limit can be scoped to anything from one second to ten minutes to several weeks.
For example, you might allow anonymous-adjacent new members only a handful of
messages per hour while letting an established "verified" role message freely.

This is an **anti-abuse feature**, not an access-control layer. It reads the
sending user's roles and applies whichever flood limit you configured; it doesn't
decide who may message whom (that's still governed by Private Message itself).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer along
   with its Private Message and Duration Field dependencies, then enable it.
2. [Configuration](configuration/index.md) — set the per-role message and thread
   limits and their durations.
