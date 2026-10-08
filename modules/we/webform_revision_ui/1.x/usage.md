<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Revision UI adds a Revisions tab and a revision history / revert / delete UI to Webform configuration entities, so changes to a form definition can be reviewed and rolled back.

---

Webform definitions are configuration, and a change to a live form (a removed element, an altered email handler, a changed confirmation message) can disrupt submissions with no built-in undo. Webform Revision UI bridges the Config Revision module and Webform: Config Revision records a revision each time a webform is saved, and this module surfaces that history in the Webform admin UI. It adds a "Revisions" local task at `/admin/structure/webform/manage/{webform}/revisions` that reuses Drupal core's version-history controller, and it reroutes Config Revision's generic revert and delete confirm forms back to the webform's own revision page. It adds no config, no settings form and no schema of its own — it is a thin, administrative governance layer whose behaviour is entirely determined by Config Revision plus three dedicated permissions (view / revert / delete all webform revisions). Because webform config can include handlers that send data externally and access settings, revision history records changes to how a form behaves — keep it admin-gated and treat reverting a live form with the care of any config change.

---

- Add a Revisions tab to every webform's manage screen.
- Review the change history of a webform configuration entity.
- See who changed a webform and when, from the revision list.
- Revert a webform to an earlier saved definition.
- Undo a broken form edit by reverting the previous revision.
- Roll back an accidental element deletion on a live form.
- Recover a previous email/handler configuration for a form.
- Restore an earlier confirmation message or redirect setting.
- Delete an obsolete webform revision from the history.
- Govern form-definition changes with an audit-style trail.
- Grant read-only revision visibility with "view all webform revisions".
- Grant revert rights separately with "revert all webform revisions".
- Grant delete rights separately with "delete all webform revisions".
- Keep revert and delete restricted to trusted administrators.
- Pair Webform with Config Revision to version form config.
- Inspect a diff-in-time of a form by comparing revisions.
- Re-save a webform to create its first tracked revision.
- Route revert/delete confirmations back to the form's revision page.
- Audit configuration drift on important public forms.
- Provide a rollback path after a bad deployment of webform config.
- Support editorial workflows that need a form change to be reversible.
- Confirm a form's current state matches an approved revision.
- Use as an administrative safety net for high-traffic forms.
