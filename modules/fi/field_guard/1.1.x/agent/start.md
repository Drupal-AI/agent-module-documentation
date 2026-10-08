<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Guard — agent index

**Fail-closed per-field access control** (`forbidden()` nothing can override — not even user 1). Version **1.1.0**. Core `^10.6||^11.3||^12`.

Authoritative via `hook_entity_field_access` (form/view/REST/JSON:API). Configure carefully — admins also lose access. Depends on core `field`, `user`. Strong security-positive design.