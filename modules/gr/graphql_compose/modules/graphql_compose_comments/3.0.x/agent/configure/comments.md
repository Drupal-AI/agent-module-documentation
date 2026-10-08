# Expose comments in the schema

No dedicated settings form. Enable the comment entity/bundles through GraphQL Compose, and
optionally turn on the posting mutation per comment bundle.

## Enable the comment mutation (post comments via GraphQL)

Config object `graphql_compose.settings.graphql_compose_server`:

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("graphql_compose.settings.graphql_compose_server");
  $c->set("entity_config.comment.comment.comments_mutation_enabled", TRUE);   // allow CreateComment
  $c->set("entity_config.comment.comment.enabled", TRUE);                     // expose the type
  $c->save();
'
drush cget graphql_compose.settings.graphql_compose_server entity_config.comment.comment
```

In the UI the comment bundle's GraphQL Compose settings show an **Enable comment mutation**
checkbox (added by this submodule's `hook_graphql_compose_entity_type_form_alter`), whose value
is stored at `comments_mutation_enabled`. The submodule also extends the config schema so this
key validates (`hook_config_schema_info_alter`).

Posting still respects Drupal's comment permissions ("Post comments" / "Skip comment approval").

## What it adds

- EntityType `Comment`; FieldTypes `CommentItem`, `CommentAuthorItem`.
- SchemaTypes `CommentAuthorType`, `CommentAvailable`.
- `CommentsSchemaExtension` + DataProducers: `CommentEdge`, `CreateComment`,
  `CommentsTypeBundleSplit`, `CommentsArrayKey`, `CommentsArrayWrap`.
- Comment threads are returned as **connections** — this is why the submodule depends on
  `graphql_compose_edges`.
