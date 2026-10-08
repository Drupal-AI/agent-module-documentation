<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GridStack integrates the GridStack.js library to build multi-column, drag-and-drop grid layouts, available as Layout Builder layouts and a UI.

---

Building a flexible multi-column layout that an editor can rearrange by dragging is a recurring need that CSS grid alone does not give you an interface for. GridStack.js is a mature library for exactly that — resizable, draggable grid widgets — and this module brings it into Drupal, exposing the grids as Layout Builder layouts (`gridstack_layouts`), a management UI (`gridstack_ui`), and an example (`gridstack_example`).

The result is that a site builder or editor can compose a page as a grid of blocks and drag them into place, with the positions saved. It sits on top of Layout Builder, so it fits the standard layout workflow rather than replacing it.

As a layout/JS integration it is low on security surface — its permissions govern who may manage grids, and the usual Layout Builder access applies to what can be placed. Confirm the library is served locally rather than from a CDN if third-party origins are a concern, and that the drag-and-drop UI is restricted to the roles who should build layouts.

---

- Build a drag-and-drop grid layout.
- Rearrange blocks by dragging.
- Create multi-column layouts.
- Add GridStack Layout Builder layouts.
- Resize layout regions visually.
- Compose a page as a grid.
- Let editors arrange a layout.
- Use GridStack.js in Drupal.
- Provide a grid UI.
- Save grid positions.
- Build a dashboard layout.
- Add responsive grid columns.
- Restrict layout building by role.
- Serve the library locally.
- Fit the Layout Builder workflow.
- Drag widgets into place.
- Build a flexible landing page.
- Manage grids in a UI.
- Provide an example grid.
- Arrange content visually.