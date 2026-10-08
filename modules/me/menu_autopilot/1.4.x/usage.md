<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Automatic, content-driven navigation menus that build their own children.

---

Menu Autopilot provides automatic, content-driven navigation — you curate the top-level menu, then let each item's children build and maintain themselves from published content (a taxonomy term, a content bundle, or a hand-picked list). Mark any link as a dynamic parent from the menu-link form's "Menu Autopilot: children of …" section; the module keeps managed child `menu_link_content` links in sync on every publish, update, unpublish, re-type, and delete. Generated links always store a canonical `entity:node/<id>` URI, so they resolve to the node's real path alias — never `/node/N` or an editorial route — which is why it is headless-safe. Choose **Sort children by → Keep current order** to preserve the sequence you drag on the menu overview (new matches append at the end), and use the token-driven **Child menu label** field (e.g. `[node:title] [node:field_subtitle]`) to give nav a shorter or decorated label without changing the page title. An "Existing children" policy decides what happens to hand-created children already under the parent (reuse matches, reuse and prune extras, add-missing-only, or replace all), plus an optional checkbox to move matching links from elsewhere in the same menu. When another module disables an automatic child during the sync's own save, the module logs it, flags it, and re-enables it on a later sync by an account that can — surfacing the disabled children in the parent form and in `drush ma:rebuild` output. The 1.4 branch also ships an optional `menu_autopilot_mcp` submodule with three MCP Sentinel-governed Tool API plugins for reading autopilot status, inspecting a single link, and normalising URIs. It's headless-ready (clean canonical URLs, multilingual) and works with traditional themes too. Depends on core `menu_link_content` and `node`; supports Drupal 10.6+ and 11.3+.

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
- Support multilingual, translatable per-language child titles.
- Choose which menus are managed on the settings page.
- Set a default child sort and limit for new dynamic parents.
- Rebuild all automatic children on demand with `drush ma:rebuild`.
- Normalize editorial node link URIs to canonical ones with `drush ma:fix-uris`.
- Find and re-enable automatic children another module disabled during a sync save.
- Avoid duplicate child links when enabling automatic children on an existing menu.
- Migrate a hand-built menu to automatic management incrementally.
- Edit an automatic child's page from its node form without breaking the menu link.
- Read the dynamic-parent status of your menus through a governed MCP tool (optional submodule).
- Ask what an API edit to one menu link will do before making it (optional MCP submodule).
- Normalise editorial menu-link URIs through a governed MCP tool (optional submodule).
