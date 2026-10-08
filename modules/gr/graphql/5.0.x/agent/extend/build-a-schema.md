<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Build a schema (SDL + resolvers)

Two routes to a working schema: **(A)** a self-contained `SdlSchemaPluginBase`, or **(B)** the
built-in `ComposableSchema` + one or more `@SchemaExtension` plugins (the recommended, modular
pattern used by the `graphql_composable` example). Either way you pair **SDL** (`.graphqls` type
definitions) with **resolvers** wired via the `ResolverBuilder` into a `ResolverRegistry`, and each
field pulls data through **DataProducer** plugins.

## A. Self-contained SDL schema

`my_module/src/Plugin/GraphQL/Schema/MySchema.php`:

```php
#[\Drupal\graphql\Attribute\Schema(id: "my_schema", name: "My schema")]
class MySchema extends \Drupal\graphql\Plugin\GraphQL\Schema\SdlSchemaPluginBase {
  protected function registerResolvers(\Drupal\graphql\GraphQL\ResolverRegistryInterface $registry): void {
    $builder = new \Drupal\graphql\GraphQL\ResolverBuilder();
    $registry->addFieldResolver('Query', 'article',
      $builder->produce('entity_load')
        ->map('type', $builder->fromValue('node'))
        ->map('bundles', $builder->fromValue(['article']))
        ->map('id', $builder->fromArgument('id'))
    );
    $registry->addFieldResolver('Article', 'title',
      $builder->produce('entity_label')->map('entity', $builder->fromParent()));
  }
}
```

Colocate the SDL as `my_module/graphql/my_schema.graphqls` (path derived from the plugin id):

```graphql
type Query { article(id: Int!): Article }
type Article { id: Int! title: String! }
```

## B. Composable schema + extension (recommended)

Use the built-in `ComposableSchema` (id `composable`) — or subclass it as the
`graphql_composable` example does — and add a `@SchemaExtension`:

```php
#[\Drupal\graphql\Attribute\SchemaExtension(
  id: "my_extension", name: "My extension", schema: "composable",
)]
class MyExtension extends \Drupal\graphql\Plugin\GraphQL\SchemaExtension\SdlSchemaExtensionPluginBase {
  public function registerResolvers(\Drupal\graphql\GraphQL\ResolverRegistryInterface $registry): void {
    $builder = new \Drupal\graphql\GraphQL\ResolverBuilder();
    $registry->addFieldResolver('Query', 'ping', $builder->fromValue('pong'));
  }
}
```

Ship SDL beside it as `my_module/graphql/my_extension.extension.graphqls` (adds to an existing
type) and/or `my_module/graphql/my_extension.base.graphqls` (declares the base types). The server's
`schema_configuration.composable.extensions` lists which extensions are active.

## Write a DataProducer

```php
#[\Drupal\graphql\Attribute\DataProducer(
  id: 'my_uppercase',
  name: new \Drupal\Core\StringTranslation\TranslatableMarkup('Uppercase'),
  produces: new \Drupal\Core\Plugin\Context\ContextDefinition('string'),
  consumes: ['value' => new \Drupal\Core\Plugin\Context\ContextDefinition('string')],
)]
class MyUppercase extends \Drupal\graphql\Plugin\GraphQL\DataProducer\DataProducerPluginBase {
  public function resolve(string $value, \Drupal\graphql\GraphQL\Execution\FieldContext $context): string {
    return strtoupper($value);
  }
}
```

Use it in a resolver: `$builder->produce('my_uppercase')->map('value', $builder->fromParent())`.

## Cache metadata
Return/attach cacheability from resolvers via the `FieldContext` (`$context->addCacheableDependency()`,
`$context->addCacheTags()`, `$context->mergeCacheMaxAge(0)` to bypass). Server-level `caching`,
`query_depth`, `query_complexity`, and `disable_introspection` are set on the `graphql_server`
entity (see [../configure/servers.md](../configure/servers.md)).

## Wire it up
Create a `graphql_server` whose `schema` = your Schema plugin id, set `endpoint`, `drush cr`, and
POST GraphQL to that path. The quickest working reference is the `graphql_composable` submodule
(schema id `composable_example`, a `createArticle` mutation).
