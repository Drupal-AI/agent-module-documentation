<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FactoryTypes and the chain resolvers

A **FactoryType** knows how to create one kind of Drupal object. `FixtureFactory::create()` asks the
chain resolver for all registered FactoryTypes, calls `shouldApply($type)` on each in registration
order, and the first that returns TRUE creates the object. This is a **tagged-service collector**, not
the Drupal Plugin API — there is no plugin manager, annotation or discovery; you register a FactoryType
by tagging a service.

## The interface

`src/FactoryType/FactoryTypeInterface.php`:

- `shouldApply(string $type): bool` — does this FactoryType handle the given blueprint `type` string?
- `create(?object $attributes = NULL)` — create and persist the object; return it. (`@internal`)
- `getIdentifier(object $factory_object)` — return the object's identifier (used by
  `FixtureFactory::association()`).

Most built-in types also expose a setter (`setEntityTypeManager(EntityTypeManagerInterface)`, called via
the service `calls:` list) so they don't require the target module at `shouldApply` time — storage is
loaded lazily inside `create()`.

## The chain resolvers

- `src/Resolver/ChainFactoryTypeResolver.php` (service `factory_lollipop.factory_type.chain_resolver`)
  collects every service tagged `factory_lollipop.factory_type_resolver` via `addResolver()`
  (`service_collector`). `getResolvers()` returns them in tag order (by `priority`).
- `src/Resolver/ChainFactoryResolver.php` (service `factory_lollipop.factory.chain_resolver`) does the
  same for `factory_lollipop.factory_resolver` — those are the blueprint (`FactoryInterface`) classes,
  see [defining-factories.md](defining-factories.md).

## Built-in FactoryTypes

Declared in `factory_lollipop.services.yml`, each tagged `factory_lollipop.factory_type_resolver` with a
`priority` and `calls: [setEntityTypeManager, ['@entity_type.manager']]`.

| type string | class | priority | key required attributes / notes |
|---|---|---|---|
| `file` | `FileFactoryType` | 100 | ctor `@config.factory` + `@file_system`. Writes a random `.txt` (or copies `path`) under the default (or `scheme`/`destination`) stream; saves a permanent `file`. |
| `entity field` | `EntityFieldFactoryType` | 200 | requires `name`, `type`, `bundle`, `entity_type`; creates/loads `field_storage_config` then a `field_config` instance. |
| `entity reference field` | `EntityFieldEntityReferenceFactoryType` | 200 | entity-reference variant of the field type. |
| `node type` | `NodeTypeFactoryType` | 205 | creates a `node_type` bundle. |
| `node` | `NodeFactoryType` | 210 | requires `type` (must be an existing node type); random `title`, `langcode` und. |
| `vocabulary` | `VocabularyFactoryType` | 215 | creates a taxonomy `vocabulary`. |
| `taxonomy term` | `TaxonomyTermFactoryType` | 215 | creates a `taxonomy_term`. |
| `role` | `RoleFactoryType` | 220 | random lowercase `rid`/label; grants `permissions` via `UserCreationTrait::grantPermissions()`. `getIdentifier()` returns `[id => label]`. |
| `user` | `UserFactoryType` | 220 | also `setPasswordGenerator(@password_generator)`; defaults name/mail/pass/status/roles; returns existing user if `uid` already loads. |
| `menu` | `MenuFactoryType` | 230 | creates a `menu`. |
| `menu link` | `MenuLinkFactoryType` | 230 | creates a `menu_link_content`. |
| `media type` | `MediaTypeFactoryType` | 240 | creates a `media_type`. |
| `media` | `MediaFactoryType` | 240 | creates a `media` entity. |

The submodule `factory_lollipop_paragraphs` adds `paragraph` and `paragraph type` at priority 245
(see [../../modules/factory_lollipop_paragraphs/1.2.x/agent/api/paragraph-factory-types.md](../../modules/factory_lollipop_paragraphs/1.2.x/agent/api/paragraph-factory-types.md)).

## Adding or overriding a FactoryType

Register a service tagged `factory_lollipop.factory_type_resolver` whose class implements
`FactoryTypeInterface`. To override a built-in behaviour, give your service a **higher priority** (later
in `getResolvers()` order matters — the first matching `shouldApply()` wins, so ensure your resolver is
positioned to be reached; in practice you decorate or re-tag with the priority needed). Load the storage
lazily inside `create()` (as the built-ins do) so `shouldApply()` never requires the target module.
