<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lets editors save a work-in-progress node that has a Workflow field, bypassing required-field validation, without moving the workflow forward.

---

On node forms whose bundle has a Workflow field, `hook_form_node_form_alter` relabels the default submit to *Update workflow* and adds a *Save as draft* button carrying `formnovalidate`. The draft button's validation handler (`_workflow_save_as_draft_clear_errors`) clears all form errors so incomplete required fields don't block the save — but it re-adds an error if the editor tried to change the workflow state on a draft (state changes must go through *Update workflow*). Conversely the *Update workflow* button requires an actual state change. Integration with Inline Entity Form (`ElementSubmit::addCallback`) ensures values persist after initial creation.

Setup: enable alongside the Workflow module and attach a Workflow field to the relevant content type(s); the buttons appear automatically. No settings form, routes or permissions of its own. (Note: the module references `inline_entity_form`'s `ElementSubmit` — IEF should be present for the save-after-create path.)

---
- Save an incomplete node as a draft despite required fields.
- Add a *Save as draft* button to workflow-enabled node forms.
- Prevent workflow state changes while saving a draft.
- Require a state change when using *Update workflow*.
- Relabel the main submit button to *Update workflow*.
- Let editors park work-in-progress content safely.
- Keep required-field enforcement for real workflow transitions.
- Persist values on initial creation via Inline Entity Form.
- Separate "save progress" from "advance workflow" actions.
- Apply automatically to any bundle with a Workflow field.
- Reduce friction in long editorial workflows.
- Let authors save drafts before all required fields are filled.
- Block accidental state advancement when saving a draft.
- Guide editors to the correct button for transitions vs drafts.
- Support save-as-draft on newly created workflow content.
- Preserve draft values across an Inline Entity Form save.
