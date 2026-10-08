# Configure Quick Node Clone

Settings form `quick_node_clone.settings` (route `quick_node_clone.settings`). Config object:
`quick_node_clone.settings`. Sub-forms exist for node and paragraph exclusions
(`QuickNodeCloneNodeSettingsForm`, `QuickNodeCloneParagraphSettingsForm`).

Keys (`config/install/quick_node_clone.settings.yml`):
- `text_to_prepend_to_title` — string prefixed to the cloned title (default `"Clone of"`).
- `exclude` — fields to skip when cloning, keyed by entity kind:
  - `exclude.node.<type>` — list of field machine names excluded per content type.
  - `exclude.paragraph.<type>` — list of paragraph fields excluded per paragraph type.
- `clone_status` — publication status of the clone: `default` (same as source), or force
  published/unpublished.
- `create_group_relationships` — when the Group module is installed, recreate the source
  node's group relationships on the clone (default `true`).

The clone itself is produced by the `quick_node_clone.entity.form_builder` service
(`QuickNodeCloneEntityFormBuilder`), which builds the node add form pre-filled with a deep
copy (Paragraphs cloned recursively). Trigger route: `quick_node_clone.node` controller /
the Clone tab on a node.
