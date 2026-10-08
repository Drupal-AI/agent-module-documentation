# Selection plugins

The module provides three `@EntityReferenceSelection` plugins (in
`src/Plugin/EntityReferenceSelection/`). It defines no plugin *type*.

| Plugin id | Class | `entity_types` | `group` | Bundles field label |
|---|---|---|---|---|
| `unpublished` | `UnpublishedNodeSelection` | `{node}` | `unpublished` | "Content types" |
| `unpublished_media` | `UnpublishedMediaSelection` | `{media}` | `unpublished_media` | "Media types" |
| `unpublished_taxonomy_term` | `UnpublishedTaxonomyTermSelection` | `{taxonomy_term}` | `unpublished_taxonomy_term` | "Vocabularies" |

## How they allow unpublished entities

Each class extends core `Drupal\Core\Entity\Plugin\EntityReferenceSelection\DefaultSelection`
— **not** the core entity-specific handlers (`node`'s `NodeSelection`, `media`'s
`MediaSelection`, `taxonomy`'s `TermSelection`). Those entity-specific handlers override
`buildEntityQuery()` to add a `status = 1` (published) condition for users lacking bypass
permission. By extending the generic `DefaultSelection` instead, these plugins **never add
that condition**, so unpublished entities are returned by the reference query.

The only code override in each plugin is cosmetic: `buildConfigurationForm()` renames the
`target_bundles` element's title. No query changes, no permission changes.

## Schema

`config/schema/entity_reference_unpublished.schema.yml` aliases each selection type to
`entity_reference_selection.default`, so the handler settings validate exactly like the
default selection handler's.

## Choosing one

Set a field config's `settings.handler` to the plugin id (see
[../configure/handler.md](../configure/handler.md)). The field storage `target_type` must
match the plugin's entity type.
