<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Published Referenced Entity — agent index

Field formatters that **display a referenced entity only when it is published** (id/label/rendered). Depends on
core `field`. Version **1.1.2**. Core `^9||^10||^11`.

**Display-layer publish filter, NOT access control** — gates the formatter output on `isPublished()`;
presentation only (referenced entities' real access still governed by core on other paths — use entity access to
protect content). No independent access role.
