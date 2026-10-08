# Expose users

No dedicated settings form. Enable the User type through the GraphQL Compose schema config.

## Enable the User type

`user` has a single bundle (`user`). Config object `graphql_compose.settings.graphql_compose_server`:

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server");
  $c->set("entity_config.user.user.enabled", TRUE);
  $c->save();
'
drush cget graphql_compose.settings.graphql_compose_server entity_config.user.user
```

## What it adds

- EntityType `User`.
- `author` field on nodes: `hook_graphql_compose_entity_base_fields_alter()` maps a node's `uid`
  to an `entity_owner` field exposed as `author` (a User).
- FieldTypes: `EntityOwner`, `UserRoles`, `UserStatus`; SchemaTypes: `UserRoles`, `UserStatus`.
- DataProducers: `Viewer` (resolves the current authenticated user for a `viewer` query),
  `UserRoles`, `UserStatus`.

## Notes

- Field/entity access follows Drupal's user access rules — sensitive fields (mail, etc.) are only
  exposed to permitted viewers. Combine with `hook_graphql_compose_field_enabled_alter()` (parent
  module) to force specific user fields off.
- Combine with the Image Styles submodule to expose user-picture derivatives, and with Comments to
  resolve comment authors as Users.
