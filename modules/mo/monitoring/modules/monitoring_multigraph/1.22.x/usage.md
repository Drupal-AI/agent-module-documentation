Monitoring Multigraph lets you group several Monitoring sensors into a named "multigraph" config entity so their values can be reported and graphed together (e.g. for Munin) as one accumulated view.

---

The submodule defines a `monitoring_multigraph` config entity (config prefix `monitoring_multigraph.multigraph.<id>`) whose main property is a `sensors` map — each entry keyed by a sensor id with a `weight` and an optional custom `label`. It ships an admin UI at `/admin/config/system/monitoring/multigraphs` (list/add/edit/delete, gated by `administer monitoring`) with `MultigraphForm`/`MultigraphListBuilder`, and a REST resource (`monitoring-multigraph`) exposing multigraph data. The `Multigraph` entity provides helpers `getSensors()`, `getSensorsRaw()`, `addSensor($name, $label)`, `removeSensor($name)`, `getDefinition()`, and computes config dependencies on the referenced sensors. Two example multigraphs ship as optional config (`failed_logins_sensor`, `watchdog_severe_entries`). It depends on the base `monitoring` module and adds no permissions of its own (reuses `administer monitoring`).

---

- Combine several watchdog-severity sensors into one "severe entries" graph.
- Aggregate all failed-login sensors into a single security multigraph.
- Report several disk/opcache sensors together as one capacity view.
- Group related sensors for a Munin multigraph plugin.
- Create a custom multigraph from the `/admin/config/system/monitoring/multigraphs` UI.
- Order sensors within a multigraph using per-sensor `weight`.
- Give a sensor a friendlier per-graph `label` inside a multigraph.
- Expose aggregated sensor data to external tools via the multigraph REST resource.
- Build a multigraph in code with `Multigraph::addSensor()` and save the entity.
- Ship a multigraph as config for repeatable deployment.
- Track a group of KPIs (e.g. content counts) as one accumulated report.
- Remove a sensor from a multigraph with `removeSensor()`.
- Present a single graph of 404s across dblog and redirect sensors.
- Compare related sensors side-by-side over time.
- Keep multigraph config dependencies in sync with the sensors it references.
- Use the shipped `watchdog_severe_entries` example as a starting template.
- Use the shipped `failed_logins_sensor` example for auth monitoring.
- Provide grouped metrics for a monitoring dashboard.
- Reduce dashboard clutter by collapsing many sensors into fewer graphs.
- Export multigraph definitions for use by an external graphing system.
