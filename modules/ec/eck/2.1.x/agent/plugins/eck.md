# Dynamic entity-type "plugins" ECK builds

ECK defines **no custom plugin *manager*** (`provides_plugin_types` is empty). Instead, in
`hook_entity_type_build()` (`eck.module`) it dynamically constructs core entity-type plugin
definitions — one `ContentEntityType` per ECK type and one `ConfigEntityType` per bundle —
from the stored `eck_entity_type` config entities. This is the mechanism to understand when
you extend or introspect ECK entities.

## Per ECK type → a `ContentEntityType`

For each `eck_entity_type` with id `{id}` and label `{label}`, ECK builds a content entity
type with:

- `base_table = {id}`, `data_table = {id}_field_data`, `bundle_entity_type = {id}_type`.
- `entity_keys`: always `id`, `bundle => type`, `uuid`, `langcode`; plus, conditionally on
  the type's base-field booleans: `label => title` (if `title`), `uid`/`owner` (if `uid`),
  `created`, `changed`, `status`/`published` (if those flags).
- Handlers: `view_builder` = `EckEntityViewBuilder`, `access` =
  `EckEntityAccessControlHandler`, `list_builder` = `EckEntityListBuilder`, `views_data` =
  `EntityViewsData`, `translation` = `EckTranslationHandler`, `route_provider[html]` =
  `EckEntityRouteProvider`, forms `default`/`edit`/`delete` = `EckEntityForm` /
  `EckEntityDeleteForm`.
- `class` = `Drupal\eck\Entity\EckEntity`, `translatable = TRUE`, `provider = eck`,
  `permission_granularity = bundle`, `group = content`.
- `links.canonical` = `/{id}/{{id}}` when `standalone_url` is on, else the edit route.

## Per ECK type → a bundle `ConfigEntityType`

A companion config entity type id `{id}_type` with `bundle_of = {id}`,
`config_prefix = eck_type.{id}` (→ config `eck.eck_type.{id}.{bundle}`),
`config_export = [type, name, description]`, class `EckEntityBundle`,
`admin_permission = administer eck entity bundles`, Field-UI base route
`entity.{id}_type.edit_form`.

## Consequences for agents

- To act on an ECK entity type, use its **own** entity type id (`event`), and for its
  bundles use `{id}_type` (`event_type`) — these ids only exist *after* the type is saved
  and caches are rebuilt.
- Because these definitions are rebuilt from config on every `hook_entity_type_build()`,
  changing a base-field boolean on the type and re-saving re-installs the corresponding
  column via `EntityUpdateService` (`applyUpdates`).
- ECK does register real **derivative** plugins (local tasks/menu items) under
  `src/Plugin/Derivative/`, and a Views field plugin `EckEntityLabel` — but it exposes no
  plugin type for third parties to implement.
