GraphQL Compose: Users adds the Drupal User entity to the schema, exposes an author field on content, and provides a `viewer` query for the current user plus role/status types.

---

This submodule exposes user information through GraphQL Compose. It registers a `User` EntityType plugin (so the User type can be enabled in the schema config), FieldType plugins `EntityOwner`, `UserRoles` and `UserStatus`, and matching SchemaType plugins `UserRoles` and `UserStatus`. Via `hook_graphql_compose_entity_base_fields_alter()` it adds an `author` field to nodes (mapping a node's `uid` to an `entity_owner` field named `author`), so content can expose its author as a User. A `Viewer` DataProducer backs a `viewer` query returning the currently authenticated user, and `UserRoles`/`UserStatus` producers resolve a user's roles and active status. Requires core `user`. Enable the User type through the standard GraphQL Compose schema config; there is no settings form of its own. Field/entity access still follows Drupal's user access rules, so only permitted fields are exposed.

---

- Expose the current authenticated user through a `viewer` query.
- Add an `author` field to content so a client can show who wrote an article.
- Enable the User type in the schema (`entity_config.user.user.enabled`).
- Query a user's roles via the `UserRoles` type/field.
- Query whether a user account is active/blocked via `UserStatus`.
- Show author name/picture on decoupled article pages.
- Personalize a headless UI based on the `viewer` result.
- Expose profile fields added to the User entity (respecting access).
- Map a node's owner (`uid`) to a typed `author` User field.
- Build an author archive/byline in a decoupled front end.
- Gate front-end features by the viewer's roles.
- Return the viewer's username/email (subject to permissions) after login.
- Combine with Comments to show comment authors as Users.
- Provide author avatars via image fields + Image Styles submodule.
- Distinguish anonymous vs authenticated viewers in the client.
- Expose only the User fields a given front end needs.
- Support multi-author blogs with typed author data.
- Drive "my account" screens from the `viewer` query.
- Surface user status to hide content from blocked authors.
- Keep account management in Drupal while reading user data over GraphQL.
