# GraphQL Compose: Users — agent index

Adds the Drupal **User** entity to the schema, an `author` field on nodes, a `viewer` query for
the current user, and role/status types. Depends on `graphql_compose` + core `user`. No settings
form of its own.

- **Expose the User type, the author base field, viewer/roles/status** →
  [configure/users.md](configure/users.md)

Key facts:
- Enable the User type: `entity_config.user.user.enabled: true` in `graphql_compose.settings.graphql_compose_server`.
- Adds `author` (node `uid` → `entity_owner`) to nodes via `hook_graphql_compose_entity_base_fields_alter`.
- FieldTypes: `EntityOwner`, `UserRoles`, `UserStatus`; SchemaTypes: `UserRoles`, `UserStatus`.
- DataProducers: `Viewer` (current user), `UserRoles`, `UserStatus`. Access follows Drupal user permissions.
