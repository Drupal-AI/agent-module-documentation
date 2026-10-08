# Content Draggable — manual setup guide

**Content Draggable** (`content_draggable`) gives editors a ready‑made admin screen
where content can be reordered by click‑and‑drag, so you can arrange nodes into a
manual order instead of relying on sort‑by‑date or sort‑by‑title. It's a low‑code
convenience: rather than building your own reorderable listing, you enable this
module and get one out of the box.

Under the hood there's very little to it — and that's the point. The module has no
PHP classes, routes, services, or permissions of its own. It ships a bundled
**DraggableViews**‑powered view (`views.view.content_draggable`) plus a **Content
Draggable** link in the admin menu that points at it. DraggableViews provides the
drag handles and stores the manual order, so other views can then sort by that
stored weight. Because the whole feature is "a view plus a menu link," you can clone
or adapt the bundled view like any other — change its filters to target a specific
content type, adjust its fields, and so on.

This module needs **DraggableViews** installed as a dependency. There's no settings
form: setup is simply enabling the module and visiting the Content Draggable admin
page. Access to the page is governed entirely by the view's own access settings and
the underlying DraggableViews and content permissions, not by anything this module
adds.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its DraggableViews
   dependency with Composer, and enable it.

This module has **no configuration page** — there is no settings form. It works by
providing a view and a menu link, described in "How to use it" below. If you want to
change what the screen shows, edit the bundled view in the Views UI.

## Where it lives in the admin menu

Once enabled, a **Content Draggable** link appears in the admin menu, pointing at the
bundled view's page (reachable at `/admin/admin-content-draggable`).

## How to use it

1. Enable the module and its `draggableviews` dependency (see
   [Installation](installation/index.md)).
2. Open the **Content Draggable** admin page. You'll see a reorderable table of
   content with drag handles.
3. Drag rows into the order you want; DraggableViews saves the manual order.
4. Optionally, edit the bundled view (`views.view.content_draggable`) in the Views UI
   to add fields, change the filters (for example limit it to one content type), or
   clone it as the starting point for a custom ordering screen. Other views can then
   sort by the stored draggable weight to reflect your manual order on the front end.
