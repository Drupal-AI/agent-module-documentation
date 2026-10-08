<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Webform integrates the Webform module with Group 3.x by exposing each webform as a Group relation type, so webform submissions can be owned by and access-controlled through a Group.
---
The module derives one `group_webform` Group relation plugin per webform (via `GroupWebformDeriver`, iterating `Webform::loadMultiple()`), each targeting the `webform_submission` entity type. The relation plugin declares `entity_access = TRUE`, which is the Group module's mechanism for installing per-group permissions on that entity type and folding group membership into the submission's access check — group access is therefore enforced by Group core rather than re-implemented here. Cardinality is pinned to 1 (and the field disabled in the UI) because the integration assumes a single relation per submission. A `hook_webform_insert` clears the group-relation-type cached definitions so a newly created webform immediately becomes available as a relation. A group permission `access group_webform overview` gates a per-group Webforms operation/overview link.

This is a re-write of the contrib `group_webform` for Group 3.x, originally built for the LocalGov Microsites distribution. Operationally: install Webform and Group 3.x, enable this module, add the desired webform(s) as relations to a group type, and grant the resulting per-group create/view/update/delete webform-submission permissions to the appropriate group roles. Note the bundled `RouteSubscriber::alterRoutes()` returns immediately (its body is dead code) — no routes are altered by this module.
---
Add a webform as a relation to a Group type.
- Let group members submit a webform scoped to their group.
- Access-control webform submissions by group membership.
- Grant per-group `create webform_submission` to a group role.
- Grant per-group view/update/delete submission permissions per role.
- Provide a per-group Webforms overview link to group admins.
- Gate the overview with `access group_webform overview` group permission.
- Keep webform-submission cardinality fixed at 1 per relation.
- Expose newly created webforms as group relations automatically.
- Build a group-scoped submissions Views page.
- Use with the LocalGov Microsites distribution for per-site forms.
- Isolate one tenant's submissions from another tenant's group.
- Add existing webforms to a group via the action link.
- Create new webform relations from the group Webforms page.
- Combine with Group roles to delegate form management per group.
- Restrict submission overview to authorised group members only.