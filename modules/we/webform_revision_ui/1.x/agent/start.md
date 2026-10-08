<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Revision UI (webform_revision_ui) — agent index

Adds a **Revisions tab and revision history / revert / delete UI** to **Webform config
entities**. It is a thin bridge between the **`config_revision`** and **`webform`** modules —
Config Revision records a revision on each webform save; this module surfaces that history inside
the Webform admin UI. Package `Webform`. Core `^10.3 || ^11`, PHP `>=8.1`. License
GPL-2.0-or-later. Version **1.x** (installed `1.0.0-beta1`). No config, no schema, no settings
form, no Drush, no submodules.

- **Routes, the sub-request controller, permissions, the access check, and the form alters** →
  [config/revision-ui.md](config/revision-ui.md)

## What it actually provides

- **1 route** — `entity.webform.version-history` at
  `/admin/structure/webform/manage/{webform}/revisions`
  (`webform_revision_ui.routing.yml`), `_controller`
  `RevisionController::revisionOverview`. Requirements: custom access check
  `_access_webform_revisions: 'TRUE'` **AND** `_permission: 'view all webform revisions'`.
- **1 local task** — `entity.webform.version-history` (title *Revisions*, base route
  `entity.webform.canonical`, weight 55) in `webform_revision_ui.links.task.yml`.
- **1 controller** — `src/Controller/RevisionController.php`. `revisionOverview()` loads the
  webform's `ConfigRevision` (`ConfigRevision::loadConfigRevisionByConfigId($webform->id())`) and
  renders core's `VersionHistoryController` for it via an access-unaware sub-request
  (`router.no_access_checks`).
- **1 access check service** — `access_check.webform_revisions` →
  `src/Access/WebformRevisionsAccessCheck.php` (tag `_access_webform_revisions`). Forbids when the
  webform type is not revisionable or has no saved revision yet.
- **3 permissions** (`webform_revision_ui.permissions.yml`): `view all webform revisions`,
  `revert all webform revisions`, `delete all webform revisions`.
- **1 entity access hook** — `webform_revision_ui_config_revision_access()` in
  `.module` maps Config Revision entity ops (view / view revision / view all revisions / revert /
  delete revision) on the **`webform`** bundle to those three permissions.
- **2 form alters + 1 submit handler** — reroute Config Revision's revert/delete confirm forms'
  cancel and post-submit redirect back to `entity.webform.version-history`.
- **1 update hook** — `webform_revision_ui_update_9001()` grants the three permissions to every
  role that already has `administer config_revision`.

See the solution doc for how these wire together and how to operate the feature.
