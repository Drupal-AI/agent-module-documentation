<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides the missing revision UI (history list, view, revert) for Microcontent entities.

---

`hook_entity_type_alter()` (`microcontent_revision_ui.module`) attaches core's `RevisionHtmlRouteProvider` to the `microcontent` entity type and defines the `revision`, `version-history` and `revision-revert-form` link templates (under `/admin/content/microcontent/{microcontent}/...`), plus wires the `revision-revert` form to core's `RevisionRevertForm`. Access is enforced by `hook_ENTITY_TYPE_access()` (`microcontent_revision_ui_microcontent_access`) mapping revision operations to dedicated permissions: `view all revisions` -> `view any microcontent history`, `view revision` -> `view any microcontent revisions`, `revert` -> `revert any microcontent revisions`, `delete revision` -> `delete any microcontent revisions`; unmatched operations return `AccessResult::neutral()`. So the revision routes are properly permission-gated (no anonymous exposure). No config, service or Drush; revision-delete-form is noted as a to-do.

---

- Give editors a version history page for microcontent items.
- View a specific past revision of a microcontent entity.
- Revert microcontent to an earlier revision.
- Gate revision viewing with `view any microcontent revisions`.
- Gate history listing with `view any microcontent history`.
- Gate reverting with `revert any microcontent revisions`.
- Gate revision deletion with `delete any microcontent revisions`.
- Add revision UI without patching the Microcontent module.
- Reuse core's `RevisionHtmlRouteProvider` and `RevisionRevertForm`.
- Track editorial changes to reusable microcontent snippets.
- Audit who changed a microcontent item and roll back mistakes.
- Work on Drupal 9/10 with the Microcontent module.
- Keep revision routes under the admin content path.
- Return neutral access for unhandled operations (safe default).
- Complement microcontent editing with change history.
- Provide granular, per-operation revision permissions.
