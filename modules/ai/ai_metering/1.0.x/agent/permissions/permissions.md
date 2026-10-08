# Permissions

Defined in `ai_metering.permissions.yml`.

| Permission | Gates |
|---|---|
| `use ai_metering` | Trigger AI operations that are subject to token quota. (`restrict access: false` — grant broadly.) |
| `view ai metering dashboard` | View the per-editor cost dashboard (`/admin/reports/ai-metering`). |
| `administer ai metering` | Configure quotas, model routing, and pricing; access settings/hub/sync routes. Trusted. |
| `export ai metering usage log` | Download the raw per-call usage log (CSV/JSON). |

```
drush role:perm:add content_editor 'view ai metering dashboard'
```
