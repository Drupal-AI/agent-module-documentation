# Domain Path — how aliases are stored & resolved

Domain Path does **not** add a new alias storage table. A per-domain alias is a core
`path_alias` entity with an extra `domain_id`.

## Data model

- `hook_entity_base_field_info()` adds a `domain_id` entity-reference base field (target
  `domain`) to the **`path_alias`** entity.
- `hook_entity_type_alter()` swaps the `path_alias` entity class for
  `Drupal\domain_path\Entity\DomainPathAlias` (adds `getDomainId()/setDomainId()/hasDomainId()`)
  and its list builder.
- For each **enabled entity type** (`domain_path.settings.entity_types`), a computed base
  field `domain_path` (field type `domain_path`, widget `domain_path`, unlimited cardinality)
  is added; its widget renders one alias input per domain on the edit form.

So a domain-specific alias row is just:

```php
use Drupal\path_alias\Entity\PathAlias;
$pa = PathAlias::create(['path' => '/node/42', 'alias' => '/widget', 'langcode' => 'en']);
$pa->set('domain_id', 'my_domain');   // the Domain entity id
$pa->save();
```

Find a domain's aliases:

```php
\Drupal::entityTypeManager()->getStorage('path_alias')
  ->loadByProperties(['domain_id' => 'my_domain']);
```

The `DomainPathItem` field's `postSave()` is what creates/updates/deletes these `path_alias`
rows when you edit the `domain_path` field on a node.

## Resolution (outbound URLs)

- Services `domain_path.path_alias_manager` and `domain_path.repository` **decorate** core's
  `path_alias.manager` / `path_alias.repository`.
- `domain_path.path_processor` (`DomainPathAliasProcessor`, outbound path processor, priority
  **305**) resolves the alias whose `domain_id` matches the request/target domain; if none,
  the default (no-domain) alias is used.
- With **Domain Source** (priority 310) setting the target domain, cross-domain links resolve
  to the right per-domain alias; core's alias processor (300) is skipped once an alias is set.

## Validation constraints

The `domain_path` field carries constraints: `DomainPathUnique` (unique per domain),
`DomainPathSlash` (alias must start with `/`), `DomainPathUserAccess` (Domain Access checks),
and it overrides core's `UniquePathAlias` with a domain-aware version.

## Cleanup

`hook_entity_delete()` deletes all `path_alias` entities carrying a deleted domain's
`domain_id`.
