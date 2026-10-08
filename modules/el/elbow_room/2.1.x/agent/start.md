<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Elbow room — agent orientation

Small editorial-UX module: adds a toggle to hide the sidebar on node add/edit forms.

- Version 2.1.x, core ^9.4 || ^10, package `custom`.
- One admin route: `/admin/config/content/elbow-room` (`ElbowRoomAdminForm`), gated by `administer elbow room settings`.
- Assets: `elbow_room.css`, `elbow_room.js`, `elbow_room_state.js` via `elbow_room.libraries.yml`.
- No controllers, no anonymous routes, no entity queries — no security surface.
- Changes form layout only; core field access governs what saves.
