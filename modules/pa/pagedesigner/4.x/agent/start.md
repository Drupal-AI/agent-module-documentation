<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pagedesigner (pagedesigner) — agent index

**Drag-and-drop page builder** — pages from components. Version **4.2.9**. ~19 component submodules
(image, video, gallery, embed, svg, layout, webform, media, …).

**Security to check:** the **embed** and **svg** components render potentially-untrusted markup
(embed = external content/scripts; SVG = can carry scripts if unsanitised) — confirm how they handle
input and who configures them. Page building runs within editors' content-edit access. Enable only
components you use; restrict to trusted editorial roles.