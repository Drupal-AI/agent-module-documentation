# Monitoring — permissions

From `monitoring.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer monitoring` | sensor add/edit/delete, settings form, sensor overview, rebuild, ignore requirement keys, make files permanent. `restrict access: true`. |
| `monitoring reports` | the results report at `/admin/reports/monitoring` and per-sensor detail. |
| `monitoring verbose` | display verbose sensor config/output. |
| `monitoring force run` | force-run sensors (`monitoring/sensors/force[/{sensor}]`). |

Grant example:

```bash
drush role:perm:add monitoring_admin 'monitoring reports'
drush role:perm:add monitoring_admin 'administer monitoring'
```

Note: submodule `monitoring_prometheus` adds its own permission
`access monitoring prometheus metrics` (see its docs).
