<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Replicate is a thin integration layer that wires the contrib Replicate and Replicate UI modules into a LocalGov Drupal site — relabelling the clone action to "Clone" and granting the clone permission to the appropriate LocalGov roles.

---

It adds no routes, entities or controllers of its own. Instead it: implements `hook_localgov_roles_default()` to grant the `replicate entities` permission (provided by Replicate UI) to the LocalGov Editor role; implements `hook_menu_local_tasks_alter()` and `hook_entity_operation_alter()` to rename Replicate UI's "Replicate" tab and operations-dropbutton label to "Clone" for consistency; and (per its README) defaults all content types to be replicatable. The optional `localgov_replicate_microsites` submodule extends the same `replicate entities` grant to the Microsites Controller and Microsites Editor roles for microsites content.

Because it delegates entirely to Replicate UI, the access control is Replicate UI's: the clone tab and the `/{entity}/replicate` route require the `replicate entities` permission, which by default only LocalGov Editor (and, with the submodule, the microsites roles) hold. The module's own functional tests confirm the expected posture — an editor with the permission gets the Clone tab and a 200 on the replicate route (even for content they don't own), while a plain authenticated user and anonymous users get no tab and a 403, and removing the permission removes access. There is no anonymous or unauthenticated clone path. Cloning copies an existing entity, so an editor could duplicate unpublished content, but only with the `replicate entities` permission. Setup: install alongside Replicate + Replicate UI, enable, and (for microsites) enable the microsites submodule; adjust which roles hold `replicate entities` at `/admin/people/permissions`.

---

- Clone an existing node from its 'Clone' tab
- Replicate content using the underlying Replicate/Replicate UI stack
- Grant the `replicate entities` permission to the LocalGov Editor role by default
- Extend clone access to Microsites Controller/Editor roles via the submodule
- Relabel the Replicate tab to 'Clone' for a consistent UI
- Relabel the Replicate operations-dropbutton entry to 'Clone'
- Make all content types replicatable by default
- Adjust which roles can clone at `/admin/people/permissions`
- Let editors clone content they do not own (with the permission)
- Deny clone access to permission-less authenticated users (403)
- Deny clone access to anonymous users (403)
- Duplicate a page as a starting point for a similar new page
- Install alongside the Replicate and Replicate UI contrib modules
- Enable the microsites submodule to configure microsites-role permissions
- Rely entirely on Replicate UI's access control (no custom routes)
- Remove the permission from a role to instantly revoke clone access
