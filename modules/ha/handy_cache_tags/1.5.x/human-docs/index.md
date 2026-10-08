# Handy Cache Tags — manual setup guide

**Handy Cache Tags** (`handy_cache_tags`) is a small developer toolkit that gives
you two convenient cache tags for every entity and keeps them invalidated
automatically. For each entity it provides an entity‑type tag
(`handy_cache_tags:<entity_type>`, e.g. `handy_cache_tags:node`) and — the really
useful one — a **bundle‑level** tag
(`handy_cache_tags:<entity_type>:<bundle>`, e.g. `handy_cache_tags:node:article`).
Drupal core has a `node_list`‑style tag for "any node changed", but nothing for
"any node of bundle *article* changed"; this module fills that gap.

Whenever an entity is created, updated, or deleted, the module invalidates that
entity's two handy tags for you. It also clears the relevant tags when a bundle
config entity, a field storage, or a field config changes — so bundle and field
edits refresh your caches too, not just content saves. Your side of the deal is
simple: attach the tags you care about to a render array's `#cache['tags']`, and
the module handles clearing them at the right moment. The result is precise cache
invalidation — a "latest articles" block can refresh only when an Article
changes, instead of on every node edit.

This is purely a developer helper. It has **no UI, no configuration, no
permissions, no routes, and no Drush commands**, and depends on nothing beyond
Drupal core. You use it from code via two services: `handy_cache_tags.manager`
(build the tag strings) and `handy_cache_tags.handler` (which does the automatic
invalidation). Older procedural helper functions still exist but are deprecated in
favour of the manager service.

This guide is written for a **human** — but this particular module is really aimed
at developers, so most of the detail lives in the sibling
[`agent/`](../agent/start.md) docs, which include code examples.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to configure. From your custom code, build a tag with the manager
service and attach it to whatever you're caching:

```php
$manager = \Drupal::service('handy_cache_tags.manager');

// Clear this block only when any Article node changes:
$build['#cache']['tags'][] = $manager->getBundleTag('node', 'article');

// Or clear it when any node of any bundle changes:
$build['#cache']['tags'][] = $manager->getTag('node');
```

The module takes care of invalidation: its `hook_entity_insert/update/delete`
implementations call the handler, which invalidates both the entity‑type tag and
the bundle tag for every entity you create, edit, or delete. You never have to
write your own `hook_entity_*` invalidation logic for common per‑bundle caching.

See the [`agent/`](../agent/start.md) docs for the full list of manager methods
(`getEntityTags()`, `getEntityTypeTagFromEntity()`, `getBundleTagFromEntity()`,
`getBundleTag()`) and the exact invalidation behaviour.
