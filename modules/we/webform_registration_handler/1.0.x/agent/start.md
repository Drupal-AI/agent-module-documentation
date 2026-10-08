<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform User Registration — agent index

Webform **handler that creates a user account on submission** — maps fields to the user, assigns
**admin-configured roles** (`selected_roles`), optional email verification. Depends on `webform`.
Version **1.0.0-beta2**. Core `^10.3||^11`.

**SECURITY:** assigned roles are admin-chosen but apply to **anyone who submits** (webforms can be
public) — **never assign privileged roles on a public form**; verify the created account's active/
blocked state + verification step so accounts aren't auto-activated with elevated access. Fine with a
non-privileged role.
