<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Page links — agent index

Adds a "Page links" management panel to the Basic page (`node/page`) edit form that lists the
hyperlinks in the body and lets editors review/remove them. Core-only, no permissions of its own.

Quick facts:
- Hook: `page_links_form_node_page_edit_form_alter()` adds a collapsible group in the form's advanced area when the body has links.
- Service: `page_links.service` (`PageLinkService`) — `getLinks()` extracts anchors via regex `LINKS_PATTERN`; `themeLinksTable()` renders them; `getLinkType()` marks Local (`L`, no scheme) vs Remote (`R`).
- Scope: core `page` content type; rides node-edit access (no dedicated permission).
