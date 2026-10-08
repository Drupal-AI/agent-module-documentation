<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Permissions Template — agent index

Defines **reusable permission templates and applies them to Groups** (via `group_permissions`). Depends on
`group`, `group_permissions`. Provides permissions. Version **2.0.0-alpha2**. Core `^9||^10||^11`.

Access-control **admin tool** — configures group permissions (privileged; gate to trusted admins). Runtime
enforcement is done by Group/Group Permissions; review templates before bulk-applying. No runtime access
decision of its own.
