# Admin Audit Trail Node — agent index

Part of **`admin_audit_trail`** (see [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md)).
No config, no permissions, no plugins of its own.

What it does when enabled (`drush en admin_audit_trail_node -y`):
- Registers the **`node`** event type via `hook_admin_audit_trail_handlers()` (adds it to the report's type filter).
- Implements `hook_node_insert/update/delete` and translation insert/delete, each calling
  `admin_audit_trail_insert(['type' => 'node', 'operation' => …, 'description' => '%type: %title', 'ref_numeric' => nid, 'ref_char' => title])`.

Operations logged: `insert`, `update`, `delete`, `translation insert`, `translation delete`.
Rows appear at `/admin/reports/audit-trail` filtered to type **Node**. For the logger API,
table schema, and the CLI caveat, see the parent's
[api/admin_audit_trail.md](../../../../1.0.x/agent/api/admin_audit_trail.md).
