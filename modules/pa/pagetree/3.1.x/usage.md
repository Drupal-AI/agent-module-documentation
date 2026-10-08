<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Page Tree provides a tree widget for browsing and managing the site's menus as a page hierarchy, integrating with pathauto, restconsumer and Frontend Publishing.

---

Page Tree presents the site's menus as an interactive page-tree widget, so editors can browse and
manage the page hierarchy through the menu structure rather than a flat content list. It ties together
several systems: core menu link content and node, pathauto (for URL aliases of the pages), restconsumer
(REST consumption), hal, and Frontend Publishing (`frontendpublishing`) — indicating it is part of a
decoupled/front-end publishing workflow where the menu tree is the primary way editors navigate and
organise pages.

Use it where the information architecture is menu-driven and editors think in terms of a page tree
(sections, subsections) instead of a content listing. Because it manages menu-based hierarchy and page
creation, it provides permissions governing who can use the tree widget and manage the pages. Its
dependency set (frontendpublishing, restconsumer) means it expects that publishing stack to be present;
it is not a standalone menu module but a hierarchy/editorial UI layered on those.

---

- Browse site menus as a page tree.
- Manage the page hierarchy via a tree widget.
- Organise pages by menu structure.
- Navigate sections and subsections as a tree.
- Integrate with Frontend Publishing workflow.
- Use pathauto for page URL aliases.
- Let editors think in a page hierarchy.
- Manage menu link content as pages.
- Provide permissions for tree/page management.
- Consume REST via restconsumer.
- Support a decoupled publishing stack.
- Create pages within the tree.
- Reorder pages in the menu hierarchy.
- Depend on node, block and menu_link_content.
- Present IA as sections/subsections.
- Replace flat content lists with a tree UI.
- Tie menu tree to editorial navigation.
- Manage hierarchy for front-end publishing.
- Expect frontendpublishing to be present.
- Govern tree access via permissions.
