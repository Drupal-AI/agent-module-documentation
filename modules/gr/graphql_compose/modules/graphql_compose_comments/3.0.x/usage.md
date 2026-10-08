GraphQL Compose: Comments adds Drupal comments to the GraphQL Compose schema — reading comment threads as cursor-paginated connections and, optionally, posting new comments via a GraphQL mutation.

---

This submodule exposes the `comment` entity type through GraphQL Compose. It registers a `Comment` EntityType plugin, `CommentItem` / `CommentAuthorItem` FieldType plugins, and `CommentAuthorType` / `CommentAvailable` SchemaType plugins, plus a `CommentsSchemaExtension` and DataProducers (`CommentEdge`, `CommentsArrayKey/Wrap`, `CommentsTypeBundleSplit`, `CreateComment`) to resolve comment fields, threads and authors. Because comment threads are returned as Relay-style connections, it **depends on `graphql_compose_edges`** (and core `comment`). A per-bundle toggle `comments_mutation_enabled` (config key `entity_config.comment.<bundle>.comments_mutation_enabled`) turns on a `CreateComment` mutation so permitted users can post comments through the API; a `CommentableTrait`/`CommentQueryHelper` back the query side. Enable the comment entity/bundles through the standard GraphQL Compose schema config; there is no settings form of its own.

---

- Expose comment threads on articles/nodes to a decoupled front end.
- Read comments as cursor-paginated connections (via the Edges connection types).
- Allow a headless client to post a new comment with the `CreateComment` mutation.
- Enable comment posting per bundle with `entity_config.comment.<bundle>.comments_mutation_enabled`.
- Return a comment's author information through `CommentAuthorType`.
- Query whether commenting is available on an entity (`CommentAvailable`).
- Show comment counts and paginated comment lists in a mobile app.
- Build a decoupled blog with reader comments backed by Drupal's comment system.
- Moderate comments in Drupal while displaying them via GraphQL.
- Split comments by comment type/bundle in resolution (`CommentsTypeBundleSplit`).
- Respect Drupal comment permissions when exposing the mutation.
- Provide threaded/nested comment data to the client.
- Expose comment fields (subject, body, author name) as typed GraphQL fields.
- Let a front end paginate long comment threads efficiently with cursors.
- Combine node + comments in a single GraphQL query for a page.
- Support multiple comment fields/bundles on a content type.
- Keep spam control and approval in Drupal, surface only approved comments.
- Power a "leave a comment" form in a decoupled UI through the mutation.
- Return the newly created comment from the mutation for optimistic UI updates.
- Expose author avatars/roles alongside comments (with the Users submodule).
