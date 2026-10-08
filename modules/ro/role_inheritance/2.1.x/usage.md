<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Role Inheritance allows roles to be structured in a hierarchy and inherit privileges of other roles.

---

Role Inheritance lets you structure roles in a hierarchy — configuring one role to **inherit the
permissions** of one or more other roles, so a role automatically gains all the permissions granted to the
roles it inherits from (e.g. an "Editor" role inheriting everything "Author" can do, plus more). It is
configured at `role_inheritance.config_role_inheritance`.

Use it to build a role hierarchy without re-granting permissions on each role. Understand the model clearly:
inheritance is **additive** — an inheriting role is granted the **union** of its own and its inherited roles'
permissions (it augments the role's effective permissions when the role is loaded, the way core computes
permissions). So design the inheritance graph carefully: a role inherits **everything** its ancestors have,
which can grant more than intended if an ancestor holds a sensitive permission — review the resulting
effective permissions of each role. It only ever **grants** (never removes) permissions. It has no other
access-control role. Configure the inheritance relationships.

---

- Structure roles in a hierarchy.
- Inherit permissions from other roles.
- Grant the union of own + inherited permissions.
- Configure at role_inheritance.config_role_inheritance.
- Avoid re-granting on each role.
- Augment effective permissions at load.
- Understand inheritance is ADDITIVE.
- Design the inheritance graph carefully.
- Review each role's effective permissions.
- Know a role inherits everything its ancestors have.
- Only grant (never remove) permissions.
- Have no other access-control role.
- Build a role hierarchy.
- Configure inheritance.
- Handle role inheritance.
- Grant inherited permissions.
- Structure roles.
- Configure the relationships.
- Inherit privileges.
- Handle role hierarchy.
