# Lightning Scheduler — manual setup guide

**Lightning Scheduler** (`lightning_scheduler`) lets editors schedule future
changes to a piece of content's moderation state — for example, "publish this
article next Monday at 9 a.m." or "archive this promotion when the sale ends."
It builds directly on core's **Content Moderation**, so it works with whatever
editorial workflow you already use (Draft → Published → Archived, or your own).

On the entity edit form, next to the usual moderation-state selector, editors get
a small "add transition" interface where they can queue one or more "on this
date, move to this state" entries. Drupal's **cron** does the rest: each time cron
runs, the module checks for any scheduled transitions that are now due and applies
them — but only if the workflow legitimately allows that state change. Illegal
transitions are logged and skipped, never forced. Because the schedule is stored
as revisionable, translatable data, it travels with your content revisions and can
differ per translation.

You can schedule transitions on *any* moderated entity type, not just nodes —
media, custom entities, anything under a Content Moderation workflow. The two
scheduling fields only appear once a workflow has been assigned to an entity type,
so on a brand-new site with no moderated content, you won't see them yet.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and make sure Content Moderation is in place.
2. [Configuration](configuration/index.md) — the settings form (time precision and
   whether past dates are allowed) and how scheduling permissions work.

## Where it lives in the admin menu

Once enabled, scheduling appears right on the content edit form for any moderated
entity, near the moderation-state control — there is no separate page you send
editors to. The module's own settings form lives at **Configuration → System →
Lightning → Scheduler** (`/admin/config/system/lightning/scheduler`).

## How to use it

1. Make sure the content type (or other entity type) is under a **Content
   Moderation** workflow. Lightning Scheduler adds its fields automatically once a
   workflow is assigned.
2. Edit a piece of that content. Near the moderation-state selector you'll find the
   scheduling UI — add an entry by picking a **date/time** and a **target state**.
   You can queue several in advance (for example draft → published → archived).
3. Save the content. Nothing changes yet — the transitions are stored, waiting for
   their scheduled times.
4. When cron next runs after a scheduled time passes, the module applies that
   transition and saves the entity. Grant editors the relevant
   `schedule <workflow> transition <name>` permission so they're allowed to queue
   each transition (see [Configuration](configuration/index.md)).
