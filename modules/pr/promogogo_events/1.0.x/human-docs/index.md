# Promogogo Events — manual setup guide

**Promogogo Events** (`promogogo_events`) fetches upcoming events from a
[Promogogo](https://promogogo.com) **partner feed** and displays them in a
configurable, filterable **block** — so a venue, festival, tourism, or city site
can show its Promogogo-listed events natively, without any manual data entry.
Nothing is imported into nodes: the events come straight from the API and are
rendered live, so your site stays in sync with the feed with no content to
maintain.

The events render as a responsive grid of cards; clicking a card opens an in-page
detail popup with the event's image, dates, venue and address, a map link, the
full description, the performers, and buttons to buy tickets or open the event and
venue pages — all without leaving the page. A single block covers two needs: an
**overview mode** that shows a fixed number of events as a static teaser (good for
a sidebar or landing page), and a **paginated mode** with a "Read more" button
that fetches and appends the next page in place (a full "what's on" listing). You
can place the block more than once with different settings.

Editors can restrict a block by date window (all upcoming, today, this weekend,
the next 7 days, the next 30 days), by category, and by venue — and can optionally
expose those controls to visitors as chips and dropdowns so they can refine the
list themselves. The whole feed is fetched once into a shared cache; if the API is
briefly unreachable, the last good copy is served so the block never goes blank.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

Setup is short — a settings form for your Partner ID, then placing the block —
covered under "How to use it" below.

## Where it lives in the admin menu

The feed settings are at **Configuration → Web services → Promogogo Events**
(`/admin/config/services/promogogo-events`). You place the block at
**Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. **Enter your Partner ID.** Go to **Configuration → Web services → Promogogo
   Events** (`/admin/config/services/promogogo-events`). The **Partner ID** is
   required and ships empty — enter yours. On the same form you can optionally
   change the API base URL, the number of events to fetch, and the cache lifetime.
   Saving clears the cached feed, so changes take effect right away.
2. **Place the block.** Go to **Structure → Block layout**, choose a region, and
   place the **Promogogo events** block (found in the *Events* category).
3. **Configure the block.** On the block form choose the display mode (overview or
   paginated), the number of events or page size, an optional heading, any
   category/venue/date-window restrictions, and whether to show the visitor filter
   controls.
4. **Save.** The block now shows live events from your feed. There is no content
   type, entity, or text format to set up.

> **Note:** Your server needs **outbound HTTP access** to the Promogogo API for the
> feed to load. The block also works inside a
> [Layout Builder](https://www.drupal.org/docs/8/core/modules/layout-builder)
> layout if you prefer that to core block placement.
