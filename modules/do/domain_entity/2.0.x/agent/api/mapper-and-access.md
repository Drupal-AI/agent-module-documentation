<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — mapper, the domain_access field, runtime hooks

## `domain_entity.mapper` — `DomainEntityMapper`

The service that manages the `domain_access` field. Constants:
`FIELD_NAME = 'domain_access'`, `BEHAVIOR_AUTO = 'auto'`, `BEHAVIOR_USER = 'user'`.

| Method | Does |
|---|---|
| `getEntityTypes()` | All fieldable entity type definitions. |
| `getEnabledEntityTypes()` | Types that currently have a `domain_access` field storage (i.e. domain-enabled). |
| `loadFieldStorage($entity_type_id)` | Load `field_storage_config` `"$type.domain_access"` or NULL. |
| `createFieldStorage($entity_type_id)` | Create the `domain_access` storage: `entity_reference` → `domain`, cardinality UNLIMITED, `persist_with_no_fields = TRUE`. Idempotent. |
| `deleteFieldStorage($entity_type_id)` | Delete that storage (disables domain access on the type). |
| `addDomainField($entity_type, $bundle)` | Create the bundle `field_config` (label "Domain Access", `default_value_callback = domain_entity_field_default_domains`), set the `options_buttons` form widget, remove it from the default view display. |
| `loadField($entity_type_id, $bundle)` | Load the bundle `field_config`. |

Enable domain access on an entity type programmatically:

```php
$mapper = \Drupal::service('domain_entity.mapper');
$mapper->createFieldStorage('taxonomy_term');       // type-level (marks it "enabled")
$mapper->addDomainField('taxonomy_term', 'tags');   // bundle-level field + widget
```

## The `domain_access` field

Not to be confused with core Domain Access's node field `field_domain_access`. This field is
literally named `domain_access`, is an unlimited-cardinality entity-reference to `domain`
entities, and exists on whichever entity types you enabled.

## Runtime enforcement (`domain_entity.module` + `src/Hook/DomainEntityHook.php`)

- `hook_query_alter()` / `DomainEntityHook::queryAlter()` — adds a domain condition to entity
  queries so only entities affiliated to the active domain (or unaffiliated) are returned;
  skipped when `bypass_access_conditions` is set or the user may cross domains.
- `hook_entity_access()` / `hook_entity_create_access()` — grant/deny per the entity's domains
  and the user's assigned domains + per-bundle permissions.
- `hook_entity_presave()` — applies the `auto` behavior (assign current domain on create).
- `hook_entity_field_access()` — controls who may edit the `domain_access` field.
- `domain_entity_field_default_domains()` — default-value callback for the field.
- Helpers: `domain_entity_get_domain()`, `domain_entity_get_user_domains()`,
  `domain_entity_get_user_available_domains()`, `domain_entity_allowed_entity_types()`.

## Domain source (canonical outbound URLs)

`domain_entity.source_mapper` (`DomainEntitySourceMapper`) + the
`domain_entity.path_processor` (outbound `path_processor` priority 90) +
`DomainEntitySourceRedirectResponseSubscriber` rewrite/redirect an entity's outbound URLs to
its canonical source domain, honoring the per-bundle `exclude_routes` list. This mirrors the
core `domain_source` behavior but for arbitrary entities.
