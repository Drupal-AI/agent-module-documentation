<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Module Permissions — agent index

Protects a site with a **managed allow/deny list of modules and permissions** (stop even broad admins from
enabling certain modules / granting dangerous permissions). `module_permissions_ui` submodule. Provides
permissions. Version **4.0.0**. Core `^9||^10||^11`.

**Security/governance-positive** (least-privilege on delegated admins). Configure lists to policy; grant
control of it **only to the most trusted** operators (controls the guardrails). No other access role.
