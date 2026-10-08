<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk Edit Terms — agent index

A node action + confirmation form to add/replace/clear/remove taxonomy-term entity-reference
field values across many selected nodes from the Content overview. Provides one config setting.

- **The action, the confirm form, update modes, settings & permissions** →
  [configure/action.md](configure/action.md)

Key facts:
- Action plugin `node_edit_terms_action` (type `node`), label *"Update term references for the
  selected content."* — appears in the `admin/content` Action dropdown. Gated by **`administer nodes`**.
- Confirm form route `node.select_taxonomy_terms` → `/admin/node/select/terms`
  (`NodeSelectTerms`, requires `administer nodes`); selected node IDs pass via private tempstore.
- Update modes = `UpdateAction` enum: `none`, `clear`, `replace`, `append`, `remove`.
- Settings route `bulk_edit_terms.config_form` → `/admin/config/content/bulk_edit_terms`
  (permission **`administer bulk edit terms`**); config `bulk_edit_terms.settings.multi_value_widget_type`
  (default `entity_autocomplete`).
- Access is enforced per node (`update`) and per field (`edit`) — see the doc.
