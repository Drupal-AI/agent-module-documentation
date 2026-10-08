# Domain Path Pathauto — integration internals

No config, no UI, no permissions. It extends Pathauto behavior for Domain Path's per-domain
aliases by decorating services and overriding the domain_path field classes.

## Service decorators (verifiable on the live container)

| Service | Decorated by | Purpose |
|---|---|---|
| `pathauto.generator` | `Drupal\domain_path_pathauto\DomainPathautoGenerator` | Overrides `updateEntityAlias()` to also generate a per-domain alias for each domain_path item in CREATE state. |
| `pathauto.alias_storage_helper` | `Drupal\domain_path_pathauto\DomainAliasStorageHelper` | Domain-aware save/`loadBySourceAndDomain()`. |

Standalone service `domain_path_pathauto.alias_uniquifier`
(`DomainAliasUniquifier`) makes aliases unique **within a domain** (appends `-0`, `-1`, …).

Check on the running site:

```php
get_class(\Drupal::service('pathauto.generator'));           // DomainPathautoGenerator
get_class(\Drupal::service('pathauto.alias_storage_helper')); // DomainAliasStorageHelper
```

## Field / widget class overrides (via hooks)

`DomainPathPathautoHooks` (final, internal):

| Hook | Effect |
|---|---|
| `hook_field_info_alter()` | `domain_path` field class → `DomainPathautoItem`; list class → `DomainPathautoFieldItemList`. |
| `hook_field_widget_info_alter()` | `domain_path` widget class → `DomainPathautoWidget` (adds the per-domain "Generate automatic URL alias" checkbox). |
| `hook_entity_delete()` | Deletes all domain aliases for the entity and purges each item's pathauto state. |
| `hook_ENTITY_TYPE_delete()` (domain) | Purges pathauto state for the deleted domain (see below). |

## Per-domain pathauto state

The automatic-vs-manual choice is tracked **per domain, per entity** in the key-value store,
in domain-scoped collections:

```
domain_path_pathauto_state.{domain_id}.{entity_type}
```

- CREATE state → Pathauto generates the alias (the alias text field is disabled).
- SKIP state → the alias is manual (left to `DomainPathItem::postSave()`).

On **domain delete**, `domainDelete()` finds every key-value collection whose name starts with
`domain_path_pathauto_state.{domain_id}.` (querying the `key_value` table) and `deleteAll()`s
each — so removing a domain wipes its pathauto state across all entity types.

## Generation flow (entity save, pathauto enabled for a domain)

1. `DomainPathautoGenerator::updateEntityAlias()` runs (after the inner generator makes the
   default alias).
2. It iterates the entity's `domain_path` items; for each in CREATE state it resolves the
   Pathauto pattern via token replacement.
3. `hook_pathauto_alias_alter()` is invoked with `$context['domain_id']` set.
4. `DomainAliasUniquifier::uniquify()` makes the alias unique **on that domain**.
5. `DomainAliasStorageHelper::save()` writes the `path_alias` with the `domain_id`.
6. SKIP-state items keep their manual alias.

## Ordering

`domain_path_pathauto_install()` sets the module weight to **11** (one above Pathauto's 10) so
it runs after Pathauto during entity operations.

## Extending

```php
function mymodule_pathauto_alias_alter(&$alias, array &$context) {
  if (!empty($context['domain_id'])) {
    // Alter the alias for a specific domain.
  }
}
// hook_pathauto_pattern_alter() likewise receives $context['domain_id'].
```
