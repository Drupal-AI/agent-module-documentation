<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Link Sync (menu_link_sync) — agent index

**Adds a Synchronize button to translated node menu settings that mirrors the menu link's parent and relative tree position from the source translation.**

- **Version:** 8.x-1.x (info.yml `8.x-1.0-beta4`)
- **Core:** ^8 || ^9 || ^10 || ^11
- **Depends on:** `menu_link`; requires the contributed **Menu Link Weight** module for relative-position matching.
- **Configuration:** none.
- **How it works:** `hook_form_alter` on node forms adds a Synchronize button to Menu link settings; an AJAX callback computes and sets the parent + weight from the source translation's link.
- **Security:** no routes, permissions or endpoints of its own; acts only on the node edit form, so access is governed by that form's existing access control. No security-sensitive surface.
