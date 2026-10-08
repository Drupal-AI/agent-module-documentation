Workflow buttons replaces the Content Moderation "moderation state" select dropdown (plus its separate Save button) with one submit button per available workflow transition, labelled with the transition name — so an editor clicks "Publish" or "Send for review" directly instead of choosing a state and then saving.

---

The module provides a field widget, `workflow_buttons`, for the `moderation_state` field of any content-moderation-enabled entity. When applied, `hook_form_alter` and the widget's process callback turn the moderation-state select into a set of action buttons — one per transition the current user may perform, clustered as a dropbutton — pulling each button's label from the workflow transition's label and adding a `workflow-buttons-<transition_id>` CSS class; the first button and any "publish" transition stay as the primary button, and a "delete" transition renders as a red danger button styled like a trash link. It ships a small global settings form at `/admin/config/workflow/workflow-buttons` (`workflow_buttons.settings`, route `workflow_buttons.settings`) with one option, `display.top_buttons`, to also render the buttons at the top of the form (adapting when the Gin admin theme provides its own sticky actions). The widget has a `show_current_state` setting to display the current moderation state in the form's meta section. It sets itself as the default moderation-state form widget via `hook_entity_base_field_info_alter`, exposes a `workflow_buttons` pseudo-field (rendered as an inline form) via `hook_entity_view`, and exposes `latest_revision_state` / `current_revision_state` variables to node templates. A `hook_workflow_buttons_state_alter` lets other modules change the target state before save. It requires the core `workflows` and `content_moderation` modules and has no permissions of its own. The `workflow_buttons_trash` submodule adds a soft-delete ("Trash") workflow that pairs well with these buttons.

---

- Replace the moderation-state dropdown with clear "Draft", "Publish", "Archive" buttons.
- Let editors publish content in one click instead of picking a state then saving.
- Show only the transitions the current user is actually allowed to perform.
- Label each button from its workflow transition name (e.g. "Send for review").
- Render the workflow actions as a compact dropbutton in the form actions.
- Add a red "danger" trash/delete button for a delete transition.
- Show the workflow buttons at both the top and bottom of long edit forms.
- Display the current moderation state in the form's meta/sidebar section.
- Work with the Gin admin theme's sticky action area out of the box.
- Provide a friendlier editorial UX for non-technical content authors.
- Keep button styling consistent via the `workflow-buttons-<transition>` classes.
- Alter the chosen target state programmatically before save via a hook.
- Add custom buttons through field-widget alter hooks and route them through the state alter hook.
- Expose current/latest revision state to node templates for status badges.
- Preserve correct moderation state through the node Preview flow.
- Use per-content-type by setting the moderation_state form widget to "Workflow buttons".
- Translate button labels by translating the workflow transition labels.
- Pair with the Trash submodule for a soft-delete editorial workflow.
- Reduce editor confusion between the state select and the Save button.
- Standardise the moderation UI across all moderated content types.
- Give a one-click "Restore" action when combined with a restore transition.
