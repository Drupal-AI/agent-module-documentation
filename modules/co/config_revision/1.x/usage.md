<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Revision adds a revision history (with inline diff and revert) to configuration entities, so config edits can be reviewed and rolled back the way content revisions already can.

---

Drupal's content entities keep revisions; configuration entities do not, so an accidental or unwanted config change is hard to review or undo without config-sync tooling. Config Revision defines a lightweight, bundleable content entity (`config_revision`) whose bundles (`config_revision_type`) correspond to the config entity types you opt in on the settings form at `/admin/config/development/config-revision`. From then on, every save of an enabled config entity records a new revision (captured by `hook_entity_insert`/`hook_entity_update`), and deleting the config entity removes its revision record. Administrators can browse the revision history, view a YAML diff between the live config and any stored revision, and revert the live config back to a stored revision. Changes applied during config import are intentionally ignored so import does not spam the history. It is an administrative/governance tool: because configuration can define roles, permissions, fields and access rules, treat viewing and reverting config revisions as privileged, and keep the feature admin-gated.

---

- Add a revision history to configuration entities.
- Track every change to an opted-in config entity type.
- Record who saved each config revision and when.
- Review what a config edit changed via an inline YAML diff.
- Revert a config entity back to an earlier stored revision.
- Undo an accidental or bad configuration change.
- Audit configuration changes over time for governance.
- Opt individual config entity types in or out on the settings form.
- Make webform configs revisionable (the module's documented example).
- Make view (`views.view.*`) definitions revisionable and revertible.
- Make image style or other config entity types revisionable.
- Keep a change trail for compliance/audit requirements.
- Compare the current live config against a previous state.
- Restore a known-good config after a misconfiguration.
- Skip recording revisions during config import/sync.
- Store each revision's raw config data as a map field.
- Expose config revisions to Views via the module's Views data.
- Roll back configuration carefully with a confirm-form diff preview.
- Restrict who can administer config revision types.
- Restrict who can administer and revert config revisions.
- Give reviewers read access to the recorded config revisions.
- Pair with config-sync workflows for extra safety before deployments.
- Enable only the config types you actually need to track.
