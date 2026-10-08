<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Automatic, content-driven navigation menus that build their own children.

---

Menu Autopilot provides automatic, content-driven navigation — you curate the top-level menu, then let each item's children build and maintain themselves from published content (a taxonomy term, a content bundle, or a hand-picked list). Mark any link as a dynamic parent from the menu-link form's "Menu Autopilot: children of …" section; the module keeps managed child `menu_link_content` links in sync on every publish, update, unpublish, re-type, and delete. Generated links always store a canonical `entity:node/<id>` URI, so they resolve to the node's real path alias — never `/node/N` or an editorial route — which is why it is headless-safe. In 1.2 you can set **Sort children by → Keep current order** so automatic children keep the sequence you drag on the menu overview (new matches append at the end), and the token-driven **Child menu label** field (e.g. `[node:title] [node:field_subtitle]`) now stores titles as plain text so an ampersand in a node title is no longer escaped. An "Existing children" policy still lets you decide what happens to hand-created children already under the parent (reuse matches, reuse and prune extras, add-missing-only, or replace all), plus an optional checkbox to move matching links from elsewhere in the same menu. Editing an automatic child from its node form no longer conflicts with core's menu-link widget. It's headless-ready (clean canonical URLs, multilingual, cache-tag revalidation) and works with traditional themes too. Depends on core `menu_link_content` and `node`; supports Drupal 10.6+ and 11.3+.

---

- Build content-driven navigation menus.
- Curate the top level by hand, auto-build the children.
- Source children from a taxonomy term's tagged nodes.
- Source children from all nodes of a content type.
- Source children from a hand-picked ordered list of nodes.
- Keep menus in sync as content is published, updated, or unpublished.
- Keep a drag-and-drop child order with "Keep current order" while still auto-adding and pruning.
- Reuse hand-created links that already point at source nodes (adopt).
- Reuse matching links and prune unmanaged extras (adopt + prune).
- Add only the missing children, leaving existing links alone.
- Replace all children, rebuilding the managed set from scratch.
- Move matching unmanaged links from elsewhere in the same menu under a parent.
- Give child links custom labels via a token pattern (e.g. `[node:title] [node:field_subtitle]`).
- Include a subtitle or other node field in the menu label without changing the page title.
- Guarantee clean canonical URLs for decoupled/headless front ends.
- Expose the composed tree to GraphQL, JSON:API, or a Twig theme with no extra work.
- Fan cache-tag revalidation to decoupled frontends.
- Support multilingual, translatable per-language child titles.
- Choose which menus are managed on the settings page.
- Set a default child sort and limit for new dynamic parents.
- Rebuild all automatic children on demand with `drush ma:rebuild`.
- Normalize editorial node link URIs to canonical ones with `drush ma:fix-uris`.
- Avoid duplicate child links when enabling automatic children on an existing menu.
- Migrate a hand-built menu to automatic management incrementally.
- Edit an automatic child's page from its node form without breaking the menu link.
