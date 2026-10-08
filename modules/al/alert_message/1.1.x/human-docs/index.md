# Alert message — manual setup guide

**Alert message** (`alert_message`) provides site-wide alert banners as
entities, with scheduling. It is built for the announcements every site
eventually needs — a service outage, a weather closure, a deadline, a security
notice, a change of opening hours — that must appear across the site quickly and
then go away on their own.

Modelling alerts as entities with a **start and end time** fixes the part of
banners that usually goes wrong: not putting the alert up, but taking it down. A
banner that outlives its cause trains visitors to ignore banners, so the next
real one goes unread. With Alert message you prepare an announcement, give it a
window, and it retires itself when that window ends — no deployment and no
"someone forgot to remove the block."

There are three things worth understanding before you rely on it, covered in
[How to use it](#how-to-use-it) below: scheduling is driven by cron, a banner is
an accessibility surface, and caching decides whether the alert is seen at all.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (and its dependencies) and enable it.

## How to use it

Alerts are content entities, so you create and manage them through the admin UI
like other content: write the alert's message and set its **start** and **end**
time. The alert then appears while it is within that window. Display is done
through a **block** — the module depends on core Block — which you place into a
region of your theme so the banner shows across the site.

Three things to get right:

1. **Scheduling is cron-driven.** An alert set to appear at nine appears when
   cron next runs, not exactly at nine. For a genuinely urgent, emergency notice
   that granularity is too coarse — plan to publish it manually rather than rely
   on a scheduled time.
2. **A banner is an accessibility surface.** It should be announced to assistive
   technology rather than merely rendered, dismissible without being permanently
   hidden while it still applies, and legible at the top of the reading order.
3. **Caching decides whether it appears at all.** On a page-cached site, the
   banner's cache tag has to be invalidated when an alert starts or ends —
   otherwise the alert exists but cached pages never show it.
