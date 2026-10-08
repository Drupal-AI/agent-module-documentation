# Leaflet Dynamic Table — manual setup guide

**Leaflet Dynamic Table** (`leaflet_dynamic_table`) adds a Views display that
keeps a **data table in sync with a Leaflet map**. It provides a new attachment
type — **Leaflet Dynamic Attachment** — that you attach to a Leaflet map display;
as the visitor **pans and zooms** the map, an AJAX request re‑renders the table
to show only the entities whose markers are currently inside the map's viewport.
Scroll to a different area and the table follows; zoom out and more rows appear.

It extends the **Leaflet Views** module and is designed for browse‑by‑map
experiences: a property or store locator, an events map, a directory of places —
anywhere a map and a list should tell the same story at once. Clicking a marker
on the map highlights and scrolls to the matching row in the table, and the
table's pager is replaced with **infinite scroll**, loading more results as the
visitor scrolls.

Under the hood it is written defensively: the AJAX endpoint that feeds the table
enforces the underlying **View's own access rules** before rendering anything, so
the table can never reveal entities the visitor could not otherwise see, and it
validates and caps the input it receives. One practical limitation: a single
shared piece of JavaScript state means only **one dynamic‑attachment map per
page** is supported.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Views / Leaflet / Leaflet Views dependencies.

There is **no site‑wide settings page** for this module. All of its options live
on the attachment display inside the View you build — see "How to use it" below.

## Where it lives in the admin menu

Leaflet Dynamic Table adds no admin settings page. You configure it entirely from
the **Views UI** (**Structure → Views**), by adding a **Leaflet Dynamic
Attachment** display to a View that already has a Leaflet map display.

## How to use it

1. Build a **View** of entities that have geographic coordinates, and add a
   **Leaflet Map** display (from Leaflet Views).
2. Add a new display of type **Leaflet Dynamic Attachment**.
3. In its settings:
   - **Attach to** — choose the Leaflet map display(s) it should follow.
   - **Update on zoom / Update on pan** — choose which map interactions refresh
     the table (both are on by default).
   - **Debounce delay** — milliseconds to wait before firing the AJAX update, so
     a rapid pan does not trigger a flood of requests (default 300).
   - **Items per page** — the batch size for infinite scroll (default 25;
     enforced server‑side to a range of 5–200).
   - **Show item count** and a count message template using the `@showing` and
     `@total` tokens.
   - **Marker highlight colour** — the colour used to highlight the table row when
     its marker is clicked (default `#ffeb3b`).
4. Set the attachment's own **format** (Table, for example) and add the fields you
   want in each row.
5. Save and view the page. As you move the map, the table updates to match the
   visible markers; clicking a marker highlights its row.

> **Note:** the attachment automatically removes the parent view's item limit on
> first load so all markers appear on the map, hides the parent view's pager, and
> replaces it with infinite scroll on the table. Exposed filter changes update
> both the map markers and the table together. Only one dynamic‑attachment map is
> supported per page.
