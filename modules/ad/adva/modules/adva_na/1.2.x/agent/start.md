<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Access Nodes (adva_na) — agent index

Node integration for adva. Registers a **basic** `node` Access Consumer and bridges adva
providers to core's node-grant system via `hook_node_grants` / `hook_node_access_records`.
Depends on `adva` + core `node`. Configured on the shared adva form
(`/admin/config/people/adva`). No own permissions/routes/schema/services.

- **The node-grant bridge hooks and consumer** → [hooks/hooks.md](hooks/hooks.md)

Parent (framework, plugin authoring, security model): [../../../../1.2.x/agent/start.md](../../../../1.2.x/agent/start.md)

Key facts:
- Consumer `NodeAccessConsumer` (id `node`) extends **`AccessConsumer`** (basic), so it does NOT
  override node's access handler — node access uses core node grants and fails closed
  consistently (unlike adva's overriding-consumer path used by `adva_media`).
- `onChange()` calls `node_access_needs_rebuild(TRUE)` on config change.
- Bypass via `bypass adva access` or `bypass adva node access`.
