<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A small helper that ships a DraggableViews-powered admin content listing so editors can drag content into a manual order.

---

The module has no PHP classes. It provides a menu link ("Content Draggable" under the admin menu) pointing at a bundled view (`views.view.content_draggable`, in `config/optional`) whose page display (`view.content_draggable.page_1`) uses the DraggableViews handlers to render a reorderable table of content. Reordering is persisted through DraggableViews' own storage, which other views can then sort by.

Because the whole feature is a view plus a menu link, its access is governed by the view's access settings and the underlying DraggableViews / content permissions rather than by any code in this module. There are no routes, services, permissions files, controllers, TLS calls, or callbacks defined here. Setup is simply enabling the module (and its `draggableviews` dependency) and visiting the Content Draggable admin page; the view can be cloned or adapted like any other view.
---
- Give editors a drag-and-drop content ordering screen
- Reorder nodes manually instead of by date or title
- Provide a ready-made DraggableViews listing out of the box
- Add a "Content Draggable" admin menu link
- Persist a manual sort order via DraggableViews
- Sort other views by the stored draggable weight
- Clone the bundled view as a starting point for custom ordering
- Reorder content without writing a custom view
- Curate a hand-ordered list of content for display
- Let staff arrange featured content order visually
- Reuse DraggableViews handlers on an admin page
- Adapt the view's filters to a specific content type
- Control access through the view's access plugin
- Order a small content set for a landing block
- Provide a low-code manual-ordering tool for a site build
- Enable draggable ordering as part of an editorial workflow