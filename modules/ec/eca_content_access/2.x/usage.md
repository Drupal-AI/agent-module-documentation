<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA Content Access adds two ECA actions that grant or revoke a role's per-node access on a single node through the Content Access module.

---

Install it with Composer (`composer require drupal/eca_content_access`) and enable it with its dependencies, ECA and Content Access (`drush en eca_content_access`); it needs `eca ^2||^3` and `content_access ^2` on Drupal 10.4+/11 and PHP 8.1+. It has no settings page, permissions, routes, or Drush commands of its own — all it provides are two ECA action plugins, **Content access: grant access** (`eca_content_access_grant_access`) and **Content access: revoke access** (`eca_content_access_revoke_access`), that you drop into an ECA model in the modeller. Each acts on the node your model is processing and takes an **operation** (`view`, `view_own`, `update`, `update_own`, `delete`, `delete_own`), a **role**, a **follow-up** choice, and a **clear-cache** toggle. When it runs it edits that node's row in Content Access's per-node settings and re-acquires the node's grant records via core's node-access system. This only works on content types that have **per-node access** enabled in Content Access; otherwise the action is not permitted and does nothing. Note the `rebuild` follow-up option currently only shows a message (it does not rebuild directly), and that because the actions change access control, the correctness of your grants is the correctness of the ECA models you build — so treat model-building as trusted and test that the right users (and only them) get access.

---

- Grant a role per-node `view` access from an ECA model.
- Grant per-node `update` or `delete` access to a role on one node.
- Grant `view_own`, `update_own`, or `delete_own` for a role.
- Revoke a role's per-node access for a chosen operation.
- Drive access changes from any ECA event (e.g. entity save, workflow transition).
- Automate per-node grants without visiting the Content Access node tab by hand.
- Add the action to a node-subject ECA model in the BPMN modeller.
- Pick the operation and role in the action's config form.
- Enable per-node access on the content type first (required precondition).
- Choose a follow-up: do nothing, show a rebuild-link message, or (currently just) message.
- Toggle clear-cache to flush caches after the change when needed.
- Combine grant and revoke actions in one model to swap a role's access.
- React to a role assignment by granting matching node access.
- Restrict who can build ECA models, since these actions change access control.
- Test grants adversarially — confirm the wrong user is still denied.
- Rebuild node access permissions after changes when grants must take effect broadly.
- Verify the action actually ran (grants changed) on your content_access 2.x site.
- Keep per-node grants in sync with your editorial workflow.
- Use tokens to select which node the action operates on.
- Pair with other ECA modules to build richer access automation.
