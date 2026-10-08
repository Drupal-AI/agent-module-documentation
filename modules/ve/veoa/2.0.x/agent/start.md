# VEOA (Views Entity Operation Access) — agent index

One Views **access plugin** that gates a view on `_entity_access` for an entity taken from
the view's path. Strengthens access; adds no permissions. No settings page (`configure`
null), no Drush. Ships a config schema. Requires core Views.

- **Configure the "Entity Operation" access plugin (the three options) and how it wires a
  core route requirement** → [configure/access-plugin.md](configure/access-plugin.md)

Key facts:
- Plugin id `veoa_entity_access_operation` ("Entity Operation"),
  `src/Plugin/views/access/EntityOperation.php` extends `AccessPluginBase`.
- Options: `parameter` (path arg holding the entity, e.g. `node`), `entity_type`,
  `operation` (`view`/`update`/`create`/`delete`/…).
- Enforcement is via `alterRouteDefinition()` at view save: sets the param
  `type: entity:<entity_type>` and route requirement `_entity_access: <type>.<operation>`.
  `access()` only returns config validity (core enforces the requirement per request).
- The named parameter must exist in the display's path for the check to resolve.
