# Permissions

The module defines a single permission (`redis.permissions.yml`):

| Permission | Machine name | Gates |
|---|---|---|
| Access Redis Report | `access redis report` | The Redis status/statistics report at `/admin/reports/redis` (route `redis.report`) |

This is an administrative permission (exposes connection details and key statistics) — grant it
only to trusted roles.
