<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Privacy — agent index

Lets individual **groups be made private** — a private group **denies all operations** on the group + its
content to non-member outsiders. Depends on `group`; provides permissions. Version **1.0.0-beta4**. Core
`^9.5||^10||^11`.

Genuine access control, **fail-closed + query-level**: adds an `is_private` field; overrides the Group
permission checker (`hasPermissionInGroup` → FALSE for non-member outsiders of a private group unless
`bypass group privacy`); and **`hook_query_TAG_alter` on `_access` tags** filters private content from
listings/search (correct/strong pattern). Treat `bypass group privacy` as sensitive (trusted admins only).
