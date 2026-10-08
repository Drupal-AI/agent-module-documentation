<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Entity Operations (jsonapi_entity_operations) — agent index

**Adds a read-only "See JSON:API resource" link to the operations dropbutton of configured entity types (default: node); it does NOT add write operations.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11
- **Dependency:** core `jsonapi`.
- **Mechanism:** `hook_entity_operation()` builds a link to `jsonapi.{type}--{bundle}.individual`, gated by permission + configured `entity_types`.
- **Permissions:** `view jsonapi_entity_operations` (see the link), `administer jsonapi_entity_operations configuration` (restrict access — settings form).
- **Configure:** `/admin/config/services/jsonapi/entity_operations/settings`.

**Security:** despite the project's premise, this version exposes NO create/update/delete endpoint — it only adds a link to the standard JSON:API individual resource, gated by `view jsonapi_entity_operations`; all resource access stays under core JSON:API + entity access. No findings.

See [configure/jsonapi_entity_operations.md](configure/jsonapi_entity_operations.md).