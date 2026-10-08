<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Exposes enabled Drupal core Action config entities as clickable local actions on entity canonical pages, so permitted users can run an action against the entity they are viewing through a confirm form.

---

Expose actions is a very lightweight module (author jurgenhaas) that bridges Drupal's Action config
entities (the same "actions" used by Views Bulk Operations, Rules and core bulk operations) to the
entity view UI. On every enabled action it implements `hook_menu_local_actions_alter()` to register a
local action button that appears on the canonical route of the entity type the action targets
(`entity.<entity_type>.canonical`) — for example a "Delete content" action shows up when viewing a
node. Clicking the button routes to `expose_actions.confirm` at
`/trigger/{action}/{entity_type}/{entity_id}`, a `ConfirmFormBase` (`Confirm`) that asks "Are you
sure?" and, on submit, calls `$action->execute([$entity])` and redirects back to the entity. The
module has no settings form and no config of its own: which actions exist is managed on the core
Actions screen (`admin/config/system/actions`), and who may trigger each one is controlled by a
dynamically generated per-action permission, `access exposed action <action_id>`, listed on the core
Permissions page under the Expose actions group. If an action defines its own `confirm_form_route_name`,
the local action links to that route instead of the module's generic confirm form. Buttons only render
where the site's block layout places the "Local actions" (help/primary actions) region for that view.

---

- Add a one-click "Delete this content" button to the node view page for editors, backed by the core Delete action.
- Let editors publish or unpublish the node they are viewing without opening the edit form.
- Expose a "Make sticky" / "Remove from front page" core action as a per-node button.
- Surface a Rules-provided action on an entity's canonical page for permitted roles.
- Trigger a Views Bulk Operations-style action against a single entity from where it is displayed.
- Give a specific role access to exactly one action (e.g. only "Unpublish comment") via its dedicated permission.
- Reuse existing custom Action plugins in the entity UI without writing a controller or form.
- Provide a confirm-step ("Are you sure?") before running a destructive action on the viewed entity.
- Run an action that sends an email (core "Send email" action) about the entity being viewed.
- Expose taxonomy-term or user actions on term/user pages, not just nodes.
- Let content teams execute a state transition action from the entity page instead of a bulk view.
- Add per-action buttons that appear only on the entity types each action is configured for.
- Keep action management centralised on the core Actions config screen while exposing them in context.
- Grant action access per role using generated `access exposed action <id>` permissions.
- Offer a lightweight alternative to building a custom local action plugin for each action.
- Present multiple exposed actions side by side as local action buttons on one entity page.
- Route to an action's own confirmation form when it declares `confirm_form_route_name`.
- Redirect the user back to the entity with a status message after the action completes.
- Let site builders decide via block layout on which view modes/pages the action buttons appear.
- Combine with contrib modules that ship Action plugins to make those actions reachable in the UI.
- Provide contextual one-off action triggering for editors who should not use full bulk-operation views.
- Standardise how single-entity actions are surfaced across a multi-type content model.
