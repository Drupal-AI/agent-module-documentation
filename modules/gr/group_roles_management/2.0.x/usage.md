<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group roles management allows setting permissions to manage members of a specific group role, delegating member management per role.

---

Group roles management extends the Group module by letting you grant permission to manage the
members who hold a specific group role — delegating member administration on a per-role basis rather
than all-or-nothing. For example, a group manager could be allowed to manage "editor" members but not
"admin" members. It requires PHP 8.3, depends on the Group module, and provides its own permissions.

Use it in Group-based sites (communities, teams, memberships) that need fine-grained delegation of who
can add/remove/change members of which role. This is access-control-adjacent: it defines a delegation
boundary, so configure it carefully — granting management of a role effectively lets that user control
who holds it. Verify the per-role management permissions match your intended trust model so delegation
can't be used to escalate (e.g. don't let a lower role manage a higher-privileged role).

---

- Delegate management of specific group roles.
- Grant per-role member management.
- Let a manager manage only some roles.
- Depend on the Group module.
- Require PHP 8.3.
- Provide its own permissions.
- Manage members of a role.
- Define a delegation boundary.
- Configure per-role management carefully.
- Avoid escalation via delegation.
- Not let low roles manage high roles.
- Delegate member admin in groups.
- Support communities/teams.
- Control who holds a role.
- Fine-grained member management.
- Match delegation to trust model.
- Add/remove members per role.
- Manage group memberships.
- Restrict role management scope.
- Verify delegation permissions.
