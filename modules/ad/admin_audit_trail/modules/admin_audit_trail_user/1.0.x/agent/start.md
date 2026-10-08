# Admin Audit Trail User — agent index

Part of **`admin_audit_trail`** (see [../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md)).
No config, no permissions, no plugins of its own.

What it does when enabled (`drush en admin_audit_trail_user -y`):
- Registers the **`user`** event type via `hook_admin_audit_trail_handlers()` (adds it to the report's type filter).
- Implements `hook_user_insert/update/delete`, each calling
  `admin_audit_trail_insert(['type' => 'user', 'operation' => …, 'description' => '%name (uid %uid)', 'ref_numeric' => uid, 'ref_char' => name])`.

Operations logged: `insert`, `update`, `delete`. Rows appear at `/admin/reports/audit-trail`
filtered to type **User**. For the logger API, table schema, and the CLI caveat, see the
parent's [api/admin_audit_trail.md](../../../../1.0.x/agent/api/admin_audit_trail.md).
