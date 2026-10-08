Group Node (gnode) provides a `GroupRelationType` plugin that relates core nodes to groups, so any content type can be made "group content" — added to a group publicly or privately with per-group access.

---

gnode ships one relation plugin, `group_node` (`Drupal\gnode\Plugin\Group\Relation\GroupNode`), with a `GroupNodeDeriver` that derives a `group_node:{node_type}` variant for every node type on the site. Installing a `group_node:{bundle}` plugin onto a group type creates a `group_relationship_type` and lets editors relate nodes of that bundle to groups; because the plugin sets `entity_access: TRUE`, node access is then routed through the group's permission system. It has an entity cardinality of 1 (a node belongs to at most one group). The module adds an `access group_node overview` per-group permission and a "Nodes" operation on each group (linking to the `group_nodes` view). Its `RouteSubscriber` and `gnode.module` wire up group-scoped node create/list routes and clear the relation-type cache when node types change. A `GroupNodePermissionProvider` handler tailors the node permissions the plugin exposes. It requires core `node` and `group`.

---

- Add articles or pages to a group so only its members can see them.
- Make a content type "group content" by installing its `group_node:{type}` plugin on a group type.
- Publish nodes privately within a group (member-only) or publicly.
- Relate an existing node to a group with `$group->addRelationship($node, 'group_node:article')`.
- Give each group its own body of node content (team wiki, club news, course materials).
- Route node view/edit/delete access through per-group permissions instead of sitewide.
- Enforce that a node belongs to at most one group (entity cardinality 1).
- Grant members a group role that can create/edit/delete specific node types in their group.
- Provide a per-group "Nodes" overview listing all of a group's nodes (group_nodes view).
- Gate that overview with the `access group_node overview` per-group permission.
- Create group-scoped node creation links so members add content directly to their group.
- Derive a distinct relation plugin per node type automatically (GroupNodeDeriver).
- Migrate Organic Groups node content into structured group relationships.
- Combine public and private group content types on the same site.
- Build a multi-tenant site where each tenant group owns its own nodes.
- Restrict a landing/news section to a department group's members.
- Let group admins moderate node content belonging to their group.
- Query all nodes related to a group via `$group->getRelatedEntities('group_node:article')`.
- Support revisioned per-group node access when combined with group_support_revisions.
- Expose group node relationships in Views via the Group relationship-to-entity plugins.
