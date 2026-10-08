<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Replicate roles & configuration

**What this module does not do:** it provides no replicate route or UI itself —
those come from `replicate_ui`, which adds the `replicate entities` permission,
the "Replicate" local task/operation and the `/{entity}/replicate` confirm flow.

**Default permission grants** (`hook_localgov_roles_default` /
`hook_localgov_microsites_roles_default`):
- LocalGov **Editor** → `replicate entities`.
- With `localgov_replicate_microsites`: Microsites **Controller** and
  **Editor** → `replicate entities`.

Adjust any role's grant at `/admin/people/permissions` (Replicate section).

**Label tweaks:** `hook_menu_local_tasks_alter` renames the tab on any
`entity.node.*` route to **Clone**, and `hook_entity_operation_alter` renames
the `replicate` operation in dropbuttons to **Clone**, so the UI reads
consistently.

**Content types:** the README states all content types are set replicatable by
default; restrict this via the Replicate configuration if some types should not
be cloneable.

**Access summary:** cloning requires `replicate entities`. Editors can clone
content they do not own (confirmed by `ReplicateTabAccessTest`), so treat the
permission as a content-creation grant. Anonymous and permission-less
authenticated users are denied (403).
