# redis — agent start

Redis-backed cache / lock / flood / queue for Drupal. **Configured in `settings.php`**, not a
UI form. No admin config form; only a read-only status report at **Admin → Reports → Redis**
(`/admin/reports/redis`, route `redis.report`). Clients: PhpRedis, Relay, or Predis.

- Connect Redis + enable cache/lock/flood/queue backends (settings.php + services) → [configure/settings.md](configure/settings.md)
- Get a Redis client / call the module in code → [api/client.md](api/client.md)
- Permissions (report access) → [permissions/permissions.md](permissions/permissions.md)
