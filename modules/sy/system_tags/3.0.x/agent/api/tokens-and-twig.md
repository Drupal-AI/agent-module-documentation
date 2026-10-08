# Resolving tags: service, Twig, tokens

## Programmatic (finder manager)

```php
$manager = \Drupal::service('plugin.manager.system_tags.system_tag_finder_manager');
$finder = $manager->getInstance(['entity_type' => 'node']);
$node = $finder->findOneByTag('homepage');          // ?EntityInterface
$all  = $finder->findByTag('news_overview', 'de');  // EntityInterface[]
```

See [../plugins/system-tag-finder.md](../plugins/system-tag-finder.md) for finder semantics (access
check, published-only, newest-first, language fallback).

Helper service `system_tags.system_tag_helper` (`SystemTagHelperInterface`):
- `getFieldMap()` → `['<entityType>' => ['field_a', ...]]` of all fields targeting `system_tag`.
- `getReferenceFieldNames($entityTypeId)` → field names for one entity type, or FALSE.

## Twig function

```twig
{# system_tag_url(tagId, entityType = 'node', options = {}) #}
<a href="{{- system_tag_url('homepage') -}}">Home</a>
<a href="{{- system_tag_url('overview', 'node', {'absolute': true}) -}}">Overview</a>
```

`SystemTagsTwigExtension::getSystemTagUrl()` calls the matching finder's `findOneByTag()`; returns the
entity's canonical `Url` (with your `options`), or the string `'#'` if nothing is tagged.

## Tokens

For every entity type that has a `system_tag` reference field, a token is exposed per tag:

```
[system_tags:ENTITY_TYPE--TAG_ID]
```

e.g. `[system_tags:node--homepage]`. It resolves to the **aliased internal path** of the tagged entity
(via `path_alias.manager`), in the data entity's language when a token data entity is present.
Implemented in `system_tags.tokens.inc` (`hook_token_info` / `hook_tokens`). Handy in Pathauto
patterns, metatags, and mail bodies to reference a landmark page's path without its ID.
