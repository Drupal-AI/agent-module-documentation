# Admin Audit Trail — agent index

Logs CUD events (via admin form submissions) into the `admin_audit_trail` DB table and shows
them at `/admin/reports/audit-trail` (a View). The base module is plumbing only; per-subsystem
logging comes from the 16 `admin_audit_trail_*` submodules (enable `admin_audit_trail_node`,
`admin_audit_trail_user`, etc.). There is **no Drupal entity and no plugin manager** — the log
is a raw table and event *types* are registered through a hook.

- **Configure it** (settings, report route, permissions, row limit, cron pruning): [configure/admin_audit_trail.md](configure/admin_audit_trail.md)
- **Register a new event type / how logging is wired** (`hook_admin_audit_trail_handlers`, submodule pattern): [plugins/admin_audit_trail.md](plugins/admin_audit_trail.md)
- **Write & query log rows programmatically** (`admin_audit_trail_insert()`, the table schema, `hook_admin_audit_trail_log_alter`, CLI caveat): [api/admin_audit_trail.md](api/admin_audit_trail.md)

Submodules (each nested where documented):
- `admin_audit_trail_node` — node CUD + translations → [../../modules/admin_audit_trail_node/1.0.x/agent/start.md](../../modules/admin_audit_trail_node/1.0.x/agent/start.md)
- `admin_audit_trail_user` — user account CUD → [../../modules/admin_audit_trail_user/1.0.x/agent/start.md](../../modules/admin_audit_trail_user/1.0.x/agent/start.md)
- 14 more (auth, taxonomy, menu, media, comment, file, config, workflows, group, paragraphs, redirect, entityqueue, block_content, user_roles) — see `data.json` `submodules_detail`; all follow the same handler+entity-hook pattern as node/user.
