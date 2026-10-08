<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Masquerade Field adds a "Masquerade as" field to each user account listing the specific accounts that user may masquerade as, so impersonation is limited to a per-user allow list instead of the whole site.

---

The `masquerade` module lets a permitted user become another user — invaluable for support, where seeing exactly what a customer sees beats any description they can give — but its grant is broad: `masquerade as any user`, or masquerade of every account holding a given role. Masquerade Field narrows that grant to a list. It adds an unlimited-cardinality entity-reference base field, `masquerade_as`, to the user entity (a `masquerade_field` field type extending core's `EntityReferenceItem`, targeting `user`). Whatever accounts appear in a user's `masquerade_as` field become that user's permitted masquerade targets. The mechanism is Masquerade's own extension point: the module implements `hook_masquerade_access()`, loading the current user's `masquerade_as` values and returning `TRUE` when the requested target is on the list. Because Masquerade aggregates hook results as "any TRUE and no explicit FALSE means allow," a listed target is permitted **even if the user holds no core masquerade permission at all**. The actual switch still goes through Masquerade's CSRF-protected `/user/{user}/masquerade` route and its `masquerade_switch_user_validate()` check, so there is no separate, weaker switch path here — the module only feeds the allow decision and renders links to that route. A `masquerade_field_default` formatter (extending `EntityReferenceLabelFormatter`) renders each target as a masquerade link, but only for the current user and only when they are not already masquerading; otherwise it links to the profile. A Views field handler (`masquerade_link`) and an optional `masquerade_as` view/block expose the same list. Field access is gated by three permissions: `edit masquerade field` (`restrict access: true`) governs who may set the lists, while `view own masquerade field` and `view any masquerade field` govern who may see them. A validation constraint (`ExcludeOriginUser`) blocks listing an account as able to masquerade as itself, and the field's item list de-duplicates targets on save. Two caveats matter for any impersonation feature: a masquerading session is bounded only by the **target's** permissions, so listing a privileged account hands over that account's authority in full; and because the grant flows through `hook_masquerade_access()` returning TRUE, it overrides Masquerade's role checks and its dedicated `masquerade as super user` protection for uid 1 — whoever can edit a `masquerade_as` list decides masquerade rights, so treat `edit masquerade field` as the sensitive grant it is.

---

- Limit a support agent to masquerading only as the customers they own.
- Scope impersonation to the members of one department or team.
- Delegate account administration without granting site-wide masquerade.
- Reproduce a specific user's reported bug by becoming that exact account.
- Let a manager act for their direct reports and no one else.
- Give a helpdesk role masquerade rights over a fixed roster of accounts.
- Avoid handing out `masquerade as any user` for narrow support needs.
- Apply least privilege to impersonation via a per-user allow list.
- Debug a permissions or display issue as the affected user.
- Support a multi-tenant site where each agent handles only their tenants.
- Reduce the number of full administrators by delegating impersonation instead.
- Let a coach or instructor act for their assigned students.
- Provide masquerade in a training environment for a fixed set of demo users.
- Render clickable "masquerade as" links on a user's own profile page.
- Expose a user's masquerade roster as a block via the bundled `masquerade_as` view.
- Add a "Masquerade link" column to a custom Views listing of users.
- Let account managers switch into the client accounts they manage for QA.
- Grant conditional impersonation that an admin can revoke by editing one field.
- Separate "who may see the roster" from "who may set the roster" via distinct permissions.
- Prevent a configured user from being set to masquerade as themselves.
