# permissions — what AI Observability defines

From `ai_observability.permissions.yml`. The module defines a single permission.

| Permission | Gates |
|---|---|
| `administer ai observability` | the AI Observability settings form (`/admin/config/ai/observability`, route `ai_observability.settings`) — logging toggles, event-type selection, input/output logging, and OpenTelemetry export options |

`administer ai observability` is declared with `restrict access: true` — grant it only to
trusted roles, since enabling input/output logging causes raw prompts and provider
responses to be persisted to the logs.

Grant with drush, e.g.:

```bash
drush role:perm:add administrator 'administer ai observability'
```

Note: this permission only controls the settings form. It does not gate viewing the logs
themselves — where AI logs are stored and who can read them is determined by Drupal's
logging backend (database log, Syslog, Extended Logger DB, an external collector, etc.).
