# Content Type Audit — manual setup guide

**Content Type Audit** (`content_type_audit`) provides a simple, focused report:
**how many nodes exist for each content type** on your site. It is the kind of
number you reach for constantly during a site audit or a spring‑clean — which
content types are actually being used, which sit empty at a count of zero, and
where all your content really lives — but that Drupal does not surface in one
place out of the box.

The report is more than a bare tally. It lets you **filter by published and
unpublished** nodes, and (new in the 2.x series) **filter by a created‑date
range** so you can ask "how many Articles were created between these two dates?".
Each row also links straight to the **Content Overview** page filtered to that
type, so the report doubles as a fast way to jump into the content itself.

It is an informational **administration / reporting** tool. It reads aggregate
counts and has no access‑control role of its own — but because it reveals how
much content of each type your site holds, keep it behind the admin area and
grant access only to trusted roles. The module has no dependencies beyond core,
runs on Drupal 8 through 11, and is actively maintained. One thing to note: this
version is **not covered by Drupal's security advisory policy**, so factor that
into your risk assessment for production use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no settings form** to configure — the module is entirely a report you
read (with on‑page filters), described below.

## Where it lives in the admin menu

Once enabled, the report sits at **Reports → Content Type Audit**
(route `content_type_audit.content_report`), reachable directly at
`/admin/reports/content-type`. With the Admin Toolbar installed you can jump to
it from **Reports**.

## How to use it

1. Go to **Reports → Content Type Audit** (`/admin/reports/content-type`).
2. Read the per‑content‑type node counts. Content types with **no** nodes appear
   with a count of **0**, which is exactly what you want when hunting unused
   types to remove.
3. Use the **published / unpublished** filter to narrow the count to the status
   you care about.
4. Use the **created‑date** filter to count only nodes created between two dates
   — useful for measuring recent activity or a migration window.
5. Click a content type's link to open the **Content Overview** already filtered
   to that type, so you can act on the content you just counted.

Typical uses are auditing content distribution, planning cleanup by spotting
unused types, and scoping a migration by seeing type usage at a glance.
