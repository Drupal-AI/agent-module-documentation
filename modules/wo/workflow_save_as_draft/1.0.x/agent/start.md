<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Workflow Save As Draft (workflow_save_as_draft) — agent index

**Adds a 'Save as draft' button (formnovalidate) to node forms with a Workflow field, saving incomplete content without advancing state.**

- **Version:** 1.0.x (1.0.0-beta6)
- **Core:** ^9 || ^10 || ^11
- **Requires:** workflow (references inline_entity_form ElementSubmit for save-after-create)
- **Hook:** `hook_form_node_form_alter` — adds `save_as_draft` submit, relabels submit to *Update workflow*
- **Validation:** `_workflow_save_as_draft_clear_errors` (clears errors on draft, blocks state change), `_workflow_save_as_draft_update_workflow_validate` (requires state change on Update)
- **Detection:** `workflow_get_workflow_field_names()` per entity type/bundle
- **No routes/permissions/config of its own**

**Security:** no routes/permissions/endpoints. Uses `formnovalidate` + programmatic error-clearing only for the draft button; workflow state changes are still validated and must use *Update workflow*. Node access is unchanged (governed by core node/workflow permissions).
