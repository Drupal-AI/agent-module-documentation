# acquia_contenthub_moderation — agent start

**Experimental** submodule of **acquia_contenthub**. On a **subscriber**, it forces content
imported from Content Hub into a configured **content_moderation** state per workflow (instead of
importing everything as published), creating a non-default *forward* revision when that state is
unpublished. Depends on `acquia_contenthub_subscriber` + `content_moderation`. No routes,
permissions, Drush, or plugin types.

- **Set the per-workflow import state (via the workflow edit form or drush); runtime revision behavior** → [configure/moderation.md](configure/moderation.md)

Key facts:
- Config object `acquia_contenthub_moderation.settings`, key
  `workflows.<workflow_id>.moderation_state` (string) — the moderation state imported content
  lands in, per workflow.
- Configured by a `hook_form_workflow_edit_form_alter` that adds an "Import Moderation State"
  select; saved by `acquia_contenthub_moderation_import_moderation_state_submit()`.
- Event subscriber `create_moderated_forward_revision.pre_entity_save` =
  `CreateModeratedForwardRevision`, on `AcquiaContentHubEvents::PRE_ENTITY_SAVE` at priority **5**
  (runs late). Sets `moderation_state` on the imported entity/translations and marks a
  non-default revision (`isDefaultRevision(FALSE)`) when the state is not a published state.
- `hook_install` warns that each workflow needs a state configured; `hook_requirements` raises a
  runtime **error** for any workflow that has none.
- Extends the parent's event system (no hook/`*.api.php`); see the parent module
  `acquia_contenthub` doc `agent/extend/events.md`.
