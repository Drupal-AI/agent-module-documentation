<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Access — agent index

**Config-driven per-field access control** via `hook_entity_field_access`. Version **1.0.0-rc4**. Core `^9||^10||^11`.

Authoritative (applies to form/view/REST/JSON:API, not form-only); AccessHandler returns `forbidden()` when denied (positive). 