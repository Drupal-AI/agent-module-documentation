# Simplenews Scheduler — manual setup guide

**Simplenews Scheduler** (`simplenews_scheduler`) extends [Simplenews](https://www.drupal.org/project/simplenews)
so a newsletter can be sent automatically on a schedule — and, optionally, resent again and
again at a fixed interval. Instead of building a newsletter and clicking *send* by hand, you
set a start date and a cadence on a template newsletter node, and Drupal cron does the rest:
each time a send is due, the module clones the template into a fresh dated "edition" node and
hands that edition to Simplenews to mail out.

That makes it a good fit for a recurring digest, a "newsletter of the week/month", or a
seasonal campaign you want to pre-stage now and have fire on its launch date. Because every
send produces its own edition node, you also get an audit trail of exactly what went out and
when. A schedule can stop after a set number of editions, stop on a specific end date, or run
open-ended with no end.

The module depends on Simplenews (`^4.1`), which in turn brings in the mail infrastructure it
needs. It has **no global settings page** — everything is configured per newsletter, right on
the newsletter node's Simplenews send tab — so the module does nothing visible until you
activate a schedule on a node. Two permissions control who may schedule newsletters and who
may view a newsletter's editions overview. Developers can also rewrite each generated edition
on the fly through an alter hook (handy for date-stamped subject lines or generated bodies).

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it alongside
   Simplenews, and set the two permissions.
2. [Configuration](configuration/index.md) — activating a schedule on a newsletter, the
   frequency and stop-condition options, the Editions tab, and how cron drives the sends.

## Where it lives in the admin menu

There is no dedicated settings page. Scheduling is configured **per newsletter node**, on the
node's **Simplenews** send tab, in a *Scheduled Newsletter* section that appears for users
with the *send scheduled newsletters* permission. Each scheduled newsletter also gains a
**Newsletter Editions** tab at `/node/{node}/editions` listing its past and upcoming editions.
