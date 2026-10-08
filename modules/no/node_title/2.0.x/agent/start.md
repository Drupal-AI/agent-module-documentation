<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Title (node_title) — agent index

**Adds a `node_title` base field to nodes and groups it on the node form.**

- **Version:** 2.0.x
- **Core:** ^8.8 || ^9 || ^10 || ^11
- **Code-only:** `hook_entity_base_field_info()` + `hook_form_node_form_alter()` in `node_title.module`.
- No routes, permissions, services, or config.

**Security:** No endpoints or user-input sinks beyond a standard node base field on the permission-gated node form. No security findings.
