# consumers — agent start

Registry of API clients as `consumer` content entities + a negotiator to detect the current
consumer. Foundation for Simple OAuth / decoupled setups. Depends on `system`, `image`.
Config UI: **Consumers collection** (route `entity.consumer.collection`).
`container_rebuild_required` on install.

- Manage consumer entities + fields (client_id, default, status) → [configure/consumers.md](configure/consumers.md)
- Detect the current consumer in code (negotiator service) → [api/negotiator.md](api/negotiator.md)
- Alter the admin list builder (hook) → [hooks/hooks.md](hooks/hooks.md)
- Theme the consumer display → [theming/theming.md](theming/theming.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
