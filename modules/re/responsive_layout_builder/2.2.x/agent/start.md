<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Responsive Layout Builder — agent index

Controls **Layout Builder block display per breakpoint** (media queries — show/hide/adjust blocks by screen
size; make LB layouts responsive). Depends on core `layout_builder`, `breakpoint`. Config at
`responsive_layout_builder.settings`. Version **2.2.4**. Core `^10.1||^11`.

Content-display/layout — blocks keep their own access; **CSS-hiding is display, not access** (hidden block's
content still in the page). No access role.
