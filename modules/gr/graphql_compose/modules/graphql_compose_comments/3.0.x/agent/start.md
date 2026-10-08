# GraphQL Compose: Comments — agent index

Adds Drupal comments to the GraphQL Compose schema: comment threads as cursor-paginated
connections plus an optional `CreateComment` mutation. Depends on `graphql_compose_edges`
and core `comment`. No settings form of its own.

- **Expose comments, enable the comment mutation, the schema types/producers** →
  [configure/comments.md](configure/comments.md)

Key facts:
- Enable the posting mutation per bundle: `entity_config.comment.<bundle>.comments_mutation_enabled: true`.
- Expose the comment entity/bundle like any type: `entity_config.comment.<bundle>.enabled: true`.
- SchemaTypes: `CommentAuthorType`, `CommentAvailable`; FieldTypes `CommentItem`, `CommentAuthorItem`.
- DataProducers: `CommentEdge`, `CreateComment`, `CommentsTypeBundleSplit`, `CommentsArrayKey/Wrap`.
- Threads use Edges connections (hence the `graphql_compose_edges` dependency).
