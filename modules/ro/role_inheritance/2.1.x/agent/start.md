<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Role Inheritance — agent index

Structures roles in a **hierarchy** so a role **inherits (is granted) the permissions** of the roles it
inherits from (the union of own + inherited). Config at `role_inheritance.config_role_inheritance`. Version
**2.1.1**. Core `^10||^11||^12`.

**Model:** inheritance is **additive** — augments the role's effective permissions (core-style) — a role
inherits **everything** its ancestors have (design the graph carefully; an ancestor's sensitive permission
propagates; review each role's effective permissions). Only **grants**, never removes. No other access
role.
