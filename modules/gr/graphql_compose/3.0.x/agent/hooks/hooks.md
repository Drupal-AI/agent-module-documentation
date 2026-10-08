# Hooks (`graphql_compose.api.php`)

All hooks are plain `hook_*` functions (implement in your `.module`). Signatures below.

## Add custom GraphQL types / extensions

```php
hook_graphql_compose_print_types(GraphQLComposeSchemaTypeManager $manager): void
```
Register extra `GraphQL\Type\Definition\Type` objects with `$manager->add($type)`.

```php
hook_graphql_compose_print_extensions(GraphQLComposeSchemaTypeManager $manager): void
```
Extend existing types (e.g. add fields to `Query`) with `$manager->extend($type)`;
use `$manager->get('MyType')` to reference types.

## Enable / disable pieces of the schema

```php
hook_graphql_compose_field_enabled_alter(bool &$enabled, FieldDefinitionInterface $field_definition): void
hook_graphql_compose_entity_bundle_enabled_alter(bool &$enabled, EntityInterface $entity): void
hook_graphql_compose_entity_base_fields_alter(array &$fields, string $entity_type_id): void
hook_graphql_compose_entity_interfaces_alter(array &$interfaces, GraphQLComposeEntityTypeInterface $plugin, ?string $bundle_id): void
```
Force a field/bundle on or off, add/remove exposed base fields, or add GraphQL interfaces to
an entity type.

## Alter resolution results

```php
hook_graphql_compose_field_results_alter(array &$results, $entity, GraphQLComposeFieldTypeInterface $plugin, FieldContext $context): void
```
Replace/augment the resolved value of a field (e.g. computed fields, per-entity overrides).

## Admin form alters (remember to alter config schema too)

```php
hook_graphql_compose_entity_type_form_alter(array &$form, FormStateInterface $form_state, EntityTypeInterface $entity_type, string $bundle_id, array $settings): void
hook_graphql_compose_field_type_form_alter(array &$form, FormStateInterface $form_state, FieldDefinitionInterface $field, array $settings): void
```
Add settings to the per-bundle / per-field admin form. If you store new settings you must also
extend the config schema via `hook_config_schema_info_alter()` (submodules
`graphql_compose_routes` / `graphql_compose_views` are worked examples).

## Language / inflection

```php
hook_graphql_compose_singularize_alter($original, string &$singular): void
hook_graphql_compose_pluralize_alter($singular, string &$plural): void
hook_graphql_compose_entity_translate_alter(?EntityInterface &$entity, array $variables): void   // $variables: entity, langcode
hook_graphql_compose_current_language_alter(?string &$langcode, array $variables): void          // $variables: preferred, context, fallback, fallback_used
```
Control how query names are singularised/pluralised, which translation of an entity is
returned, and the language used for a resolved field context.
