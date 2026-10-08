<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure CloudFront tag invalidation

Enable the submodule (`drush en cloudfront_purger_tags -y`) — it pulls in `purge_queuer_coretags`.
There is no admin route of its own; you use it through Purge plus one config value.

## Use the tag-aware purger

The submodule adds a second purger plugin, **`cloudfront_tags`** (label "CloudFront Purger (with
Cache Tags)"), whose supported types are `{tag, path, wildcardpath, everything}` — i.e. the base
purger's types **plus `tag`**. Register it with Purge instead of (or as well as) the plain
`cloudfront` purger:

```bash
drush p:purger-lsa            # lists both 'cloudfront' and 'cloudfront_tags'
drush p:purger-add cloudfront_tags
drush p:purger-ls
```

It reuses the parent's `cloudfront_purger.settings` (distribution id, AWS credentials, `disabled`
black-hole flag — see the parent module's configure doc). For each tag invalidation it sends a path
`#<hash>` to CloudFront (the `#` prefix is how CloudFront tag invalidations are expressed).

## The `Cache-Tags` response header

A Purge TagsHeader plugin (`@PurgeTagsHeader id="cloudfront"`, `dependent_purger_plugins =
{"cloudfront_tags"}`) adds a header of the response's hashed cache tags. The header **name** is
configurable:

```yaml
# cloudfront_purger_tags.settings
cache_tag_header_name: 'Cache-Tags'   # default; regex ^[A-Za-z][A-Za-z0-9-]*$
```

```bash
drush cget cloudfront_purger_tags.settings cache_tag_header_name
drush cset cloudfront_purger_tags.settings cache_tag_header_name X-Cache-Tags -y
```

This **must match** the header name configured on the CloudFront distribution (see below). Header
value = comma-separated hashed tags after the filter → prioritize → hash pipeline (see
[../extend/services.md](../extend/services.md)).

## CloudFront distribution requirement

CloudFront must be told to track the tag header. On the distribution enable `CacheTagConfig`:

```json
{ "CacheTagConfig": { "Enabled": true, "HeaderName": "Cache-Tags" } }
```

`HeaderName` must equal `cache_tag_header_name`. Configure via AWS CLI / CloudFormation / Terraform
(this module does not manage the distribution).

## Blocklist and limits

- **Filtering** uses the `purge_queuer_coretags` blocklist
  (`purge_queuer_coretags.settings:blacklist`) — tags whose prefix is blocklisted are dropped from the
  header so it reflects what would actually be invalidated. Tune it at
  `/admin/config/development/performance/purge`.
- **CloudFront limits**: max 50 tags per cached object, 256 chars/tag, 1,783 chars per header value,
  10,240 chars total. Hashing (6 chars) and prioritization (entity tags first) keep you under them; if
  a response has >50 tags, only the first 50 (highest priority) are stored by CloudFront.
- Keep Drupal's debug cacheability headers **off** in production
  (`$settings['http.response.debug_cacheability_headers']`) — they emit verbose unhashed tags.
