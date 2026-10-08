<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Advanced Role provides advanced role access control for views, supporting AND/OR/NOT logic across roles.

---

Views Advanced Role provides an advanced role-based access plugin for Views — going beyond core's simple
"any of these roles" role access to support more expressive logic (require all selected roles, any, or
exclude roles), so a View can be restricted by nuanced role combinations. Its access check returns proper
allowed/forbidden results based on the configured role logic. It depends on core Views.

Use it where a View's access needs role logic core's plugin can't express (e.g. "has role A AND role B", or
"NOT role C"). It is a genuine access-control feature: it correctly returns forbidden when the role condition
isn't met (it doesn't fail open), gating the View's route. When adopting, verify the configured role logic
matches your intent (test that the right users are allowed/denied). Configure the role access on the View.

---

- Restrict a View by advanced role logic.
- Support AND/OR/NOT role combinations.
- Require all/any/exclude roles.
- Go beyond core's role access.
- Return proper allowed/forbidden.
- Depend on core Views.
- Gate the View's route by roles.
- Not fail open.
- Verify the role logic matches intent.
- Test allowed/denied users.
- Restrict by role combinations.
- Configure role access on the View.
- Express nuanced role access.
- Require role A AND role B.
- Exclude a role.
- Handle complex role access.
- Provide advanced role plugin.
- Restrict views by roles.
- Configure the access.
- Control View access by role.
