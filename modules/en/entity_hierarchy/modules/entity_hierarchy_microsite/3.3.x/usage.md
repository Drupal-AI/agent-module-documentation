Entity Hierarchy Microsites turns any subtree of an Entity Hierarchy into a "microsite": a Microsite config-like content entity points at a home node, and the module auto-generates a section menu, branding/logo block, and a block visibility condition scoped to everything below that home node.

---

The submodule defines a `entity_hierarchy_microsite` content entity (managed at
`/admin/structure/entity-hierarchy-microsites`, the `configure` route
`entity.entity_hierarchy_microsite.collection`, permission
`administer entity hierarchy microsites`) with fields **name**, **home** (an entity_reference
to the root/landing node), **generate_menu** (boolean) and **logo** (a media reference). When
`generate_menu` is on, it derives menu links for the home node and all its hierarchy
descendants (`MicrositeMenuLinkDiscovery` + a menu-link deriver), into a dedicated
`entity-hierarchy-microsite` menu, with per-item overrides stored as
`eh_microsite_menu_override` entities. It ships a **Microsite menu** block
(`entity_hierarchy_microsite_menu`, with level/depth/expand settings), a **Microsite branding**
block (`entity_hierarchy_microsite_branding`, renders the microsite logo), and a block
visibility **condition** `entity_hierarchy_microsite_child` ("is a child of a microsite") so
blocks can be shown only within a section. A `entity_hierarchy_microsite` cache context and the
`ChildOfMicrositeLookup` service (`findMicrositesForNodeAndField`) resolve, for any node, which
microsite(s) it belongs to by walking the nested-set tree. It provides two alter hooks
(`hook_entity_hierarchy_microsite_menu_item_url_alter`, `hook_entity_hierarchy_microsite_links_alter`).

---

- Turn a section of a page tree (a landing node + its descendants) into a branded microsite.
- Auto-generate a navigation menu for a section from its Entity Hierarchy descendants.
- Give a microsite its own logo/branding via the branding block.
- Show a block only on pages within a particular microsite using the child-of-microsite condition.
- Build department/campaign sub-sites that live inside one Drupal site and one page tree.
- Provide a "section menu" block that expands to a configurable depth of the hierarchy.
- Keep a microsite's menu in sync automatically as pages are added/moved in the tree.
- Override individual auto-generated menu items (title/URL) without breaking regeneration.
- Point a microsite at any node as its home/landing page via the home field.
- Scope theming/branding to a subtree without separate multisite installs.
- Resolve which microsite a given node belongs to in code via ChildOfMicrositeLookup.
- Use the microsite cache context so blocks vary correctly per section.
- Restrict a promotional block to a single campaign microsite.
- Present consistent per-section navigation across deep documentation trees.
- Let editors manage microsites from an admin collection UI (no code).
- Choose whether a microsite auto-builds a menu with the generate_menu toggle.
- Add a media-based logo per microsite and render it site-section-wide.
- Alter microsite menu item URLs (e.g. for decoupled front ends) via the URL alter hook.
- Add extra links to a microsite's generated navigation via the links alter hook.
- Run multiple independent microsites off different branches of the same hierarchy.
- Combine with Entity Hierarchy Breadcrumb for section-scoped breadcrumbs and menus.
- Drive a "current section" menu block that starts at a chosen hierarchy level.
