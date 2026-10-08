# Group Actions — agent index

Six configurable Action plugins for the Group module (add/remove/update group content and
memberships), meant to be driven by VBO or ECA. No config page (`configure` null), no
permissions of its own (access delegates to Group), no Drush. Depends on `group`; provides
a config schema for the action configurations.

- **The action plugins, their configuration keys, values syntax, v1/v2 handling, access** →
  [plugins/actions.md](plugins/actions.md)

Key facts:
- Actions: `group_add_content`, `group_remove_content`, `group_update_content` (type `node`,
  `deriver = GroupActionDeriver` → per-entity-type variants) and `group_add_member`,
  `group_remove_member`, `group_update_member` (type `user`, preset `content_plugin =
  group_membership`).
- Config keys: `operation` (create/update/delete), `content_plugin`, `group_id` (ID or UUID,
  token-aware), `entity_id` (optional, token-aware), `values` (`key: value` per line,
  token-aware), `add_method` (create only: skip_existing / always_add / update_existing).
- `access()` maps to Group relationship permissions; there is NO trust-boundary bypass.
- Detects Group v1 vs v2/v3 by service presence and calls `addContent()`/`addRelationship()`
  accordingly.
