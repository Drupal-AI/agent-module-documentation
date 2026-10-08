<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Workspaces Access — agent index

Provides **granular per-workspace editing restrictions** (create/update/delete, notably on the Live workspace).
Depends on core `workspaces`. Provides permissions. Version **1.1.0**. Core `^10.3||^11`.

**Safe design**: `hook_entity_access` applies only to Live + C/U/D, dispatches a `workspace_check` event, returns
a subscriber's `forbidden()` or **NULL** (defer to core) — can only **tighten**, never grant (fail-closed,
additive). Layers on core Workspaces access.
