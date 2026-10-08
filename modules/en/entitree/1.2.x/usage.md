<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entitree organizes content entities into a hierarchical (tree) structure and manages their URL aliases from that hierarchy.

---

Entitree gives a Drupal site a single hierarchical tree of entities. Each position in the tree is an `entitree_location` entity that points at a real entity (a node, a taxonomy term, or an "empty" placeholder location used for structural folders). The tree itself is stored as a nested set in per-language `entitree_structure_{langcode}` tables using the `allegiance-group/nested-set` library, which makes ancestor/descendant/child lookups efficient. When you place an entity in the tree, Entitree builds its path from the parent path plus a path segment and writes a `path_alias`, so the tree owns the entity's URL. Entity-type support is pluggable: the `entitree_node` and `entitree_taxonomy_term` submodules add node and taxonomy-term support via `EntitreeEntityType` plugins, `entitree_location_rules` auto-creates locations for entities that match configured rulesets (a Pathauto-style automation), and `entitree_permissions` adds cascading, priority-ordered allow/deny access rules keyed on tree position and evaluated on top of core entity access. All management screens live under `/admin/structure/entitree` and require the `administer entitree` permission. Multilingual support is only partially built; the project recommends avoiding it on multilingual sites for now.

---

- Build a single site-wide hierarchy (tree) of content entities.
- Organize nodes into parent/child structures under a site root.
- Organize taxonomy terms into an Entitree hierarchy (beyond a single vocabulary).
- Add "empty" placeholder locations to act as structural folders with no backing content.
- Generate and maintain URL aliases for entities from their position in the tree.
- Keep child aliases in sync automatically when a parent path segment changes.
- Use Entitree instead of Pathauto to derive aliases from hierarchy plus tokens.
- Auto-create tree locations for new/updated entities via location rulesets (Entitree Location Rules).
- Match entities to rulesets by entity type and by bundle before placing them.
- Template location labels and path segments using entity tokens (node/term tokens).
- Browse the tree in the admin UI at /admin/structure/entitree and drill into any branch.
- Add a node or term to a chosen parent by browsing to the parent and selecting it.
- Move an existing location to a new parent by re-selecting its parent in the tree browser.
- Give an entity multiple locations (aliases) in the tree while marking one as the main location.
- Reconcile ("organize") an entity's orphaned path aliases against its Entitree locations.
- Enable which entity types can participate in the tree from the Entitree settings form.
- Define per-entity-type operations (view/edit/manage locations/delete) surfaced on locations.
- Grant or deny access to entities by their tree location using role-based rules (Entitree Permissions).
- Cascade a permission down a whole sub-tree, letting descendants override it.
- Assign priorities to competing permission rules on a location to control which wins.
- Restrict edit/delete operations to an entity's main location only.
- Provide a breadcrumb-friendly hierarchy whose caches invalidate when paths change.
- Expose the tree structure to other code through the `entitree.manager` service API.
- Extend supported entity types by writing your own `EntitreeEntityType` plugin.
- Render tree/location operations in Twig via the provided `entitree_location_operations()` function.
