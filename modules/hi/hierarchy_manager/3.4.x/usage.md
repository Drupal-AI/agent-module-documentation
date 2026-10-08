Hierarchy Manager replaces Drupal core's draggable-table UI for taxonomy terms and menu links with a scalable, filterable, drag-and-drop tree (jsTree by default), and exposes a plugin architecture so other modules can add tree management for any entity or swap in a different front-end library.

---

Core's draggable table cannot present a massive hierarchy on one page; Hierarchy Manager solves this by rendering the hierarchy as a JavaScript tree that loads and updates over JSON endpoints. It ships two **setup plugins** (`hm_setup_taxonomy`, `hm_setup_menu`) that decide which entity forms get taken over, and one **display plugin** (`hm_display_jstree`) that renders the tree with jsTree. You create a **HM Display Profile** config entity (`/admin/structure/hm_display_profile`) choosing a display plugin and its JSON options, then enable setup plugins and bind them to a profile and to specific bundles/menus on the config form (`/admin/config/user-interface/hierarchy_manager/config`). Once enabled, the taxonomy term overview and menu edit forms are replaced by the tree. Dragging a node issues an authenticated, CSRF-token-protected request to update endpoints that re-check per-term/per-link access before saving weights and parents. The jsTree (and optional jsoneditor) libraries load from a CDN when not present under `/libraries`. Everything is pluggable via two plugin managers, letting contrib add hierarchy management for other entity types or render with a non-jsTree library.

---

- Manage a large taxonomy vocabulary (thousands of terms) as one filterable tree instead of a paginated draggable table.
- Reorder taxonomy terms by dragging nodes and persist their weights.
- Re-parent a taxonomy term by dragging it under a different parent term.
- Manage menu link hierarchy for a specific menu as a jsTree.
- Reorder and re-parent menu links via drag and drop.
- Give term editors a workable UI for deep multi-level vocabularies.
- Filter/search within a large tree to find a term or link quickly.
- Restrict tree management to a vocabulary by relying on the `edit terms in <vid>` permission.
- Create a reusable display profile with custom jsTree theme/options as JSON.
- Apply the same display profile across several vocabularies for consistent UX.
- Enable hierarchy management only for selected content bundles/menus.
- Require a confirmation step before a drag change is saved (profile `confirm` option).
- Add hierarchy management for a custom entity type by implementing an `hm_setup_plugin`.
- Render the hierarchy with a different JS library by implementing an `hm_display_plugin`.
- Self-host jsTree under `/libraries/jquery.jstree/3.3.15/` to avoid the CDN.
- Provide a JSON options editor experience via the bundled jsoneditor library.
- Handle terms with multiple parents (shown under each parent, non-draggable to avoid ambiguity).
- Feed tree data to a custom front-end via the taxonomy/menu JSON endpoints.
- Integrate a third-party admin dashboard that needs a large-hierarchy editor.
- Keep the core term/menu edit forms while only swapping the overview UI.
- Localize/translate tree labels (terms are pulled in the current content language).
