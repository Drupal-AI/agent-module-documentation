<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Module Permissions protects a site with a managed allow/disallow list of modules and permissions.

---

Module Permissions **restricts what site administrators can do** — it maintains a **managed allow/deny
list of modules and permissions**, so you can prevent even users with broad admin access from enabling certain
modules or granting certain (dangerous) permissions. It ships a `module_permissions_ui` submodule, provides
its own permissions, in the Administration package.

Use it to enforce least-privilege on delegated administrators. This is a **security/governance-positive** tool
(it constrains privileged users — e.g. stop a site-builder role from enabling PHP-executing modules or
granting `administer permissions`). Configure the allow/deny lists to match your policy, and grant control of
Module Permissions **itself** only to the most trusted operators (whoever controls the list controls the
guardrails). It has no other access-control role. Configure the managed lists.

---

- Restrict what admins can do.
- Manage an allow/deny list of modules.
- Manage an allow/deny list of permissions.
- Prevent enabling dangerous modules.
- Prevent granting dangerous permissions.
- Ship a UI submodule.
- Enforce least-privilege on admins.
- Grant control of it to top-trusted operators only.
- Configure lists to match policy.
- Provide its own permissions.
- Have no other access-control role.
- Configure the managed lists.
- Handle module/permission guardrails.
- Constrain privileged users.
- Configure the guardrails.
- Restrict permissions.
- Handle the lists.
- Limit admins.
- Set the policy.
- Provide admin guardrails.
