# flexible_permissions — agent start

A developer API (no UI, no config) that gathers, calculates and caches permissions from many
sources per **scope**, enabling Policy Based Access Control. Implemented by access-defining
modules (Group relies on it since Group 2.0.0). Core deps only (`^10.3 || ^11`). No permissions,
no Drush, no config schema, no annotation/attribute plugin type — extensibility is via **tagged
services** collected into a chain, bridged to core's Access Policy API in 2.0.x.

- Write & register a permission calculator (tagged service / Access Policy) → [plugins/flexible_permissions.md](plugins/flexible_permissions.md)
- Chain calculator + checker services, scopes, CalculatedPermissions value objects, VariationCache caching → [api/flexible_permissions.md](api/flexible_permissions.md)
