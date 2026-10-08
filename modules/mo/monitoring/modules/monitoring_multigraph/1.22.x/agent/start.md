# Monitoring Multigraph — agent index

Groups several Monitoring sensors into a **multigraph** config entity for aggregated reporting/graphing.
Depends on `monitoring`. Reuses the `administer monitoring` permission.

- **The multigraph config entity, admin UI, entity API** → [configure/multigraphs.md](configure/multigraphs.md)

Key facts:
- Config entity `monitoring_multigraph` (prefix `monitoring_multigraph.multigraph.<id>`); key property
  `sensors` = map of `{sensor_id: {weight, label}}`.
- Admin UI: `/admin/config/system/monitoring/multigraphs` (list/add/edit/delete), perm `administer monitoring`.
- Entity API: `getSensors()`, `addSensor($name, $label)`, `removeSensor($name)`, `getSensorsRaw()`.
- REST resource `monitoring-multigraph`; two example multigraphs ship as optional config.
