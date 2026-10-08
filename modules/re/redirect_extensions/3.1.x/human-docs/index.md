# Redirect Extensions — manual setup guide

**Redirect Extensions** (`redirect_extensions`) adds the bulk operations and
export tools the contrib Redirect module leaves out. Redirect stores each
redirect as an entity with a source, a destination, and an HTTP status code, and
its admin UI edits them one at a time. That is fine until a migration leaves
hundreds of redirects pointing at a path that has since moved, or you realise a
batch created as 302 should have been 301 — at which point editing them
individually is an afternoon lost. This module supplies the missing bulk forms.

Specifically it lets you **change the status code** or **change the destination
URL** of many redirects at once, adds tracking of who created and updated each
redirect and when, turns the "To" URL into a clickable link in the listing, and
**exports** redirects to a CSV file. It reuses Redirect's own **administer
redirects** permission rather than adding a new one.

Two things worth weighing before a bulk change. Bulk-changing destinations is
**not reversible through the UI**, so be sure of the new target first. And
redirect status codes carry real SEO meaning — a **301** tells search engines the
move is permanent and transfers ranking signals, while a **302** does not — so a
bulk code change is a deliberate decision, not just tidying.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Redirect and
   Views data export dependencies, and enable it.

There is **no dedicated settings page** for this module — it adds bulk-operation
forms and export, described in "How to use it" below.

## How to use it

All of these live under the Redirect admin at **Configuration → Search and
metadata → URL redirects** (`/admin/config/search/redirect`) and require the
**administer redirects** permission.

- **Bulk-change status codes** — go to
  `/admin/config/search/redirect/edit/status` to change the HTTP status code
  (e.g. 302 → 301) across many redirects at once. Choose the code deliberately:
  301 is permanent and passes SEO value, 302 is temporary and does not.
- **Bulk-change destinations** — go to
  `/admin/config/search/redirect/edit/dest` to repoint many redirects to a new
  destination URL in one operation. This is **not undoable** through the UI, so
  double-check the target before you apply it.
- **Export to CSV** — export the redirect list to a CSV file (this is why the
  module depends on Views data export) — useful for handing redirects to an SEO
  consultant or reviewing them in a spreadsheet.
- **Extra tracking and display** — redirects now record *Created By*, *Created
  Date*, *Updated By*, and *Updated Date*, and the "To" URL shows as a clickable
  link in the listing.
