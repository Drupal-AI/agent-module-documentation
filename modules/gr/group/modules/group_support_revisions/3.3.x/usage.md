Group Support: Revisions makes revision access over grouped entities depend on the group — it adds per-group "view/revert/delete revision" permissions to every group relation whose target entity is revisionable.

---

This submodule ships no config, no UI and no permissions file. Instead it registers a single decorator service that wraps Group's default permission provider handler (`group.relation_handler.permission_provider`, `decoration_priority: 50`). The decorator, `SupportRevisionsPermissionProvider`, checks whether each relation plugin's target entity type implements `RevisionableInterface`; if it does (and the plugin already defines entity permissions), it exposes four extra per-group permissions — "view all revisions", "view specific revisions", "revert revision" and "delete revision" — named `{view all|view|revert|delete} {plugin_id} entity revisions`. Because it decorates the whole handler chain, these revision permissions automatically appear for every revisionable grouped entity type (e.g. group nodes via gnode) without each relation plugin having to declare them. It requires only the parent `group` module.

---

- Let a group role grant "view revision history" over the group's revisionable content.
- Allow specific group members to revert a grouped entity to an earlier revision.
- Allow group admins to delete individual revisions of grouped content.
- Gate revision access per group rather than by sitewide permissions.
- Add revision permissions to group nodes (gnode) automatically once enabled.
- Give each group control over the revision lifecycle of the entities it contains.
- Expose "Revisions: View full version history" as a per-group permission on the group type.
- Expose "Revisions: View specific entity revisions" per group.
- Expose "Revisions: Revert specific entity revisions" per group.
- Expose "Revisions: Delete specific entity revisions" per group.
- Support editorial workflows where revision review happens within a group's own roles.
- Restrict who can browse a grouped entity's revision list to trusted group members.
- Add revision permissions to any custom revisionable entity made groupable by a relation plugin.
- Avoid copy-pasting revision permission logic into each relation plugin (handled by one decorator).
- Combine with content moderation on grouped entities so revision access is group-scoped.
- Enable per-group revert rights for team wikis or documentation stored as group nodes.
- Let clients on a multi-tenant site manage revisions only within their own group.
- Keep revision permissions off for non-revisionable grouped entity types automatically.
