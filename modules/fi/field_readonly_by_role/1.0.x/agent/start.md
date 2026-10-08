<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Read-Only by Role — agent index

**Marks fields editable for some roles and read-only for others, without hiding them**. Provides permissions.
Version **1.0.1**. Core `^10||^11`.

**SECURITY (campaign finding, Danger 2)** — enforced **only via `hook_form_alter` (`#disabled`)**, with **no
`hook_entity_field_access`**. It holds on the entity form (core respects `#disabled`) but is **bypassed by
JSON:API/REST/Quick Edit/VBO/programmatic** writes. A **UI convenience, not a field-access control** — for real
per-role field protection use `hook_entity_field_access()`/field permissions.
