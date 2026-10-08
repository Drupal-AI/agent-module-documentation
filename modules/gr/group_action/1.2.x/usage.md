Group Actions provides configurable Drupal Action plugins that add content or users to a Group, remove them, or update the group relationship — designed to be driven by VBO (Views Bulk Operations) or ECA.

---

The module supplies six action plugins built on `ConfigurableActionBase`: `group_add_content`, `group_remove_content`, `group_update_content` (type `node`, with a deriver that also produces per-entity-type variants), and `group_add_member`, `group_remove_member`, `group_update_member` (type `user`, subclasses that preset `content_plugin = group_membership`). Each action stores an `operation` (create/update/delete), a `content_plugin` (the Group relation/content plugin id), a `group_id` (numeric ID or UUID, token-aware), an optional `entity_id` (defaults to the entity the action runs on, token-aware), a key/value `values` list of raw field values (one `key: value` per line, token-aware), and for "create" an `add_method` (skip existing / always add / update existing). It transparently supports both Group v1 (`plugin.manager.group_content_enabler`, `addContent()`) and v2/v3 (`group_relation_type.manager`, `addRelationship()`) by detecting which service exists. `access()` delegates to the group's own relationship permissions (create/update/delete `any`/`own`, admin permission, and site-admin roles), so it never bypasses Group access. Because they are standard actions, they appear anywhere actions are consumed — most usefully in VBO views and in ECA models (with a BPMN.io modeller fallback for the group autocomplete). A `Compatibility` helper raises the ECA recursion threshold around group saves so relationship changes don't trip ECA's recursion guard.

---

- Bulk-add selected nodes to a Group via a VBO view.
- Bulk-remove nodes from a Group.
- Bulk-update the group relationship fields of selected content.
- Add selected users as members of a Group in bulk.
- Remove users from a Group's membership in bulk.
- Update existing memberships (e.g. change group roles) in bulk.
- Assign group roles when adding a member by putting `group_roles: <group>-<role>` in the values.
- Add a user to a group as part of an ECA "on user login/insert" model.
- Add a node to a group automatically when it is published, via ECA.
- Remove content from a group when it is unpublished or deleted, via ECA.
- Target the group by numeric ID or by UUID.
- Resolve the target group dynamically from a token (e.g. `[node:field_group:target_id]`).
- Resolve the operated-on entity from a token instead of the action's default entity.
- Choose "only add when not yet added" to avoid duplicate relationships.
- Choose "always add" to allow multiple relationships of the same content.
- Choose "update if already added" to upsert a relationship.
- Set arbitrary relationship field values (one `field: value` per line) on add/update.
- Work unchanged against Group v1, v2, or v3 installations.
- Restrict who can run the action by relying on the group's create/update/delete permissions.
- Build editor tools that move many items between groups from a single admin view.
