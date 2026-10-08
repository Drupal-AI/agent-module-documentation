# Advanced Scheduler — manual setup guide

**Advanced Scheduler** (`advanced_scheduler`) extends the **Scheduler** module so
that scheduled changes are not limited to just *publish* and *unpublish*. On a
site that uses content moderation, "published" is only one of several workflow
states — Draft, Needs Review, Published, Archived, and whatever custom states you
define. Base Scheduler can only flip content between published and unpublished at
a chosen time. Advanced Scheduler lets you schedule a move to **any moderation
state**.

That turns scheduling into the timing layer for an editorial workflow rather than
a simple publish switch. You can embargo a story so it flips to *Published* at 9am
on launch day, automatically archive time-limited content, or set a staged review
deadline that moves an item to *Needs Review* at a set time. It works with content
moderation's states and transitions.

One thing to keep in mind for security: a scheduled transition **runs
automatically**, without a person present to authorise it at the moment it fires.
So confirm that scheduled transitions honour your workflow's rules — that
scheduling a move to Published is governed the same way a manual move would be,
not a way around transition permissions — and restrict who is allowed to set
schedules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and satisfy its Scheduler and moderation dependencies.

## Where it lives in the admin menu

Advanced Scheduler does not add a standalone admin section. It builds on
Scheduler and content moderation, so its options appear where those already
live — in Scheduler's settings on each content type and in the scheduling fields
on the node edit form, now able to target moderation states rather than only the
publish flag.

## How to use it

1. Make sure **Scheduler** and your content-moderation setup (workflow, states,
   transitions) are configured and working first — Advanced Scheduler is a layer
   on top of them.
2. Enable Advanced Scheduler.
3. When editing a piece of content, use the scheduling fields to pick a **date/time
   and a target moderation state** (for example, "move to Published on launch day"
   or "move to Archived at the end of the month"). At the scheduled time,
   Scheduler runs the transition.
4. **Restrict who can schedule.** Because a scheduled transition executes on its
   own, limit the permission to set schedules to trusted editors, and confirm the
   scheduled move respects your workflow's transition permissions.
