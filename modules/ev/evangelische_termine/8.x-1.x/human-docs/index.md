# Evangelische Termine — manual setup guide

**Evangelische Termine** (`evangelische_termine`) brings events from the German
church-events portal *evangelische-termine.de* into a Drupal site. It is built for
parish and church websites (its package is "Vernetzte Kirche") that want to embed
their events, teasers, and room/resource booking from that central service without
re-entering everything by hand.

The module works entirely through **blocks**. It provides a filtered event-list
block (with its own search-filter form and a "more" pagination form), an event
teaser/slider block, and a resource-booking form block. When a visitor loads a page
that contains one of these blocks, Drupal reaches out to the configured
evangelische-termine.de host, fetches the matching event data, and renders it with
the module's own templates. The [Colorbox](https://www.drupal.org/project/colorbox)
module is used to show event details in a lightbox, which is why Colorbox is a
required dependency.

Because the content is pulled live from an external service, your site makes
**outbound (egress) requests** to evangelische-termine.de whenever these blocks
render. Keep that host trusted.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, pull in
   Colorbox, and enable everything.

There is **no central settings page** for this module. All configuration happens on
each individual block when you place it, described in "How to use it" below.

## Where it lives in the admin menu

Evangelische Termine adds no configuration page of its own. You work with it entirely
from **Structure → Block layout** (`/admin/structure/block`), where you place and
configure its blocks. Colorbox has its own settings under **Configuration → Media →
Colorbox** if you want to tune the lightbox.

## How to use it

1. Go to **Structure → Block layout** and click **Place block** in the region where
   you want events to appear.
2. Choose one of the provided blocks:
   - **Evangelische-Termine Veranstaltungsliste mit Filter** — the filtered event
     list, with a filter form and "more" pagination.
   - The **teaser/slider** block — a compact rotating display of events.
   - The **resource-booking form** block — an embedded form for reserving rooms or
     resources.
3. In each block's settings, enter the organizer ID (**Veranstalter-ID**) and the
   evangelische-termine.de **host**, then choose display options such as grouping
   (none, or by keyword) and whether to show blocked events. For the resource-booking
   block, restrict it to the specific resource IDs you want to expose.
4. Save the block. Event data is fetched server-side from the configured host and
   rendered on the page; Colorbox shows the details in a lightbox.
