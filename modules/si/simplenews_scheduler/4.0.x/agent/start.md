# Simplenews Scheduler — agent index

Schedules and repeats Simplenews sends. Adds a schedule form to the Simplenews node send tab, stores
the schedule in a custom DB table, and on cron clones the template node into dated "edition" nodes and
sends them. Depends on `simplenews` (^4.1). No global settings form (`configure` null).

- **Schedule fields, the `simplenews_scheduler` table, cron send logic, permissions, the one config
  value, and the Editions tab** → [configure/scheduling.md](configure/scheduling.md)
- **`hook_simplenews_scheduler_edition_node_alter` — rewrite each cloned edition before it saves** →
  [hooks/edition.md](hooks/edition.md)

Key facts:
- Permissions: `send scheduled newsletters` (add/edit a schedule on the send tab), `overview scheduled
  newsletters` (view `/node/{node}/editions`).
- Cron entry point `simplenews_scheduler_cron` → due schedules → `simplenews_scheduler_clone_node` →
  new edition node → Simplenews send.
- Config: `simplenews_scheduler.settings:default_send_action` (int, default `5`).
