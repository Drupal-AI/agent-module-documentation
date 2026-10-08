<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tag processing pipeline & swappable services

`CloudFrontTagsHeader::getValue(array $tags)` builds the header value in three steps:

```php
$tags = $this->cacheTagFilter->filter($tags);        // 1. filter
$tags = $this->cacheTagPrioritizer->prioritize($tags); // 2. prioritize
$hashes = $this->cacheTagsHash->hashTags($tags);       // 3. hash
return implode(',', $hashes);
```

Each step is a service behind an interface (all autowired — `_defaults: autowire: true`), so you can
override any of them in your own `services.yml`.

## 1. Filter — `CacheTagFilterInterface`

Default `DefaultCacheTagFilter`: drops any tag whose prefix appears in
`purge_queuer_coretags.settings:blacklist` (so the header matches what Purge would actually
invalidate). If the blocklist is empty, all tags pass.

```yaml
services:
  Drupal\cloudfront_purger_tags\CacheTagFilterInterface:
    class: Drupal\my_module\MyCacheTagFilter
```

## 2. Prioritize — `CacheTagPrioritizerInterface`

Default `DefaultCacheTagPrioritizer`: returns tags in the order
**entity tags → list tags → other**, so the most valuable survive CloudFront's 50-tag cap:

- entity tags: match `/^[a-z_]+:\d+$/` (e.g. `node:123`, `taxonomy_term:45`),
- list tags: contain `_list` (e.g. `node_list`, `node_list:article`),
- other: everything else (e.g. `config:system.site`, `rendered`).

## 3. Hash — `CacheTagsHashInterface`

Default `CacheTagsHash`: `hashTag($tag)` = `substr(hash('xxh3', $tag), 0, 6)` (6 hex chars,
`HASH_LENGTH = 6`; ~16.7M values). `hashTags()` maps it over the array. This same hash is used by the
`cloudfront_tags` purger to build `#<hash>` invalidation paths, so header and invalidation agree.

```yaml
services:
  Drupal\cloudfront_purger_tags\CacheTagsHashInterface:
    class: Drupal\my_module\MyCacheTagsHash
```

## The purger's tag handling

`CloudFrontTagsPurger` extends the base `CloudFrontPurger` and overrides only:

```php
protected function processTagInvalidation(TagInvalidation $invalidation, array &$paths): void {
  $hash = $this->cacheTagsHash->hashTag($invalidation->getExpression());
  $paths[] = '#' . $hash;
}
```

So a `node:123` tag invalidation becomes a CloudFront path like `#d240cc`. Everything else (path,
wildcardpath, everything, the disabled black-hole, AWS call) is inherited unchanged from the parent
purger (see the parent module's `api/purger.md`).

## Verifying the hash on a live site

```bash
drush php:eval '$h=\Drupal::service("cloudfront_purger_tags.cache_tags_hash"); print "#".$h->hashTag("node:1");'
```
