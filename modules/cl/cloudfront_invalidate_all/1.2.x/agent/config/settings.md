<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, whitelist matching & the invalidation call

## Install / enable

`drush en cloudfront_invalidate_all`. Requires `aws/aws-sdk-php ^3.0` via Composer (pulled by the
module's `composer.json`). No Drupal module dependencies. After enabling, the module is **inert until
configured and un-disabled** — see below.

## Settings form

`src/Form/CloudFrontInvalidateAllSettingsForm.php` (`ConfigFormBase`, form id
`cloudfront_invalidate_all_settings`), at `/admin/config/services/cloudfront-invalidate-all`, permission
`administer cloudfront invalidate all` (`restrict access: true`). Editable config:
`cloudfront_invalidate_all.settings`.

| field | #type | config key | default | notes |
|-------|-------|-----------|---------|-------|
| Temporarily disable CloudFront invalidations | checkbox | `disabled` | **`true`** (from `config/install`) | when set, `invalidateTags()` returns immediately |
| CloudFront Distribution ID | textfield | `distribution_id` | `''` | validated `preg_match('/^[A-Z0-9]+$/')` — uppercase letters + digits only |
| AWS Region | textfield | `region` | `us-east-1` | passed to `CloudFrontClient` |
| Cache Tag Whitelist | textarea (10 rows) | `whitelist` | `['node_list', 'node:']` | one prefix per line; `submitForm()` trims, drops blanks, re-indexes |
| Enable debug logging | checkbox | `debug` | `false` | emits `debug`-level log messages about tag processing |

Config schema: `config/schema/cloudfront_invalidate_all.schema.yml` (`config_object`; `whitelist` is a
`sequence` of `string`). The distribution ID can equally be set outside the form, e.g. in `settings.php`:
`$config['cloudfront_invalidate_all.settings']['distribution_id'] = getenv('DISTRIBUTION_ID');`.

## How invalidation is triggered — `CloudFrontInvalidator::invalidateTags()`

The service is tagged `cache_tags_invalidator` (`.services.yml`), so Drupal core calls `invalidateTags($tags)`
on **every** cache-tag invalidation. It short-circuits, in order:

1. `$tags` empty → return.
2. `disabled` config truthy → return. **(Ships true, so nothing happens out of the box.)**
3. `distribution_id` not set → log `error` "CloudFront distribution id not configured" and return.
4. `whitelist` empty → return (an empty allow-list means *nothing* ever triggers).
5. Filter `$tags`: a tag is kept only if `strpos($tag, $prefix) === 0` for some whitelisted `$prefix`
   (i.e. the tag **string starts with** the prefix). This is an **allow-list**, despite the README calling it
   a "black list." Default prefixes `node_list` and `node:` match `node_list`, `node:1`, `node:2`, …
6. If no tag matched → return (optionally debug-logs the skip).
7. Otherwise build `new CloudFrontClient(['region' => $region ?? 'us-east-1', 'version' => 'latest'])` and call
   `createInvalidation()` with `DistributionId => $distribution_id` and a single path `Items => ['/*']`,
   `Quantity => 1`, `CallerReference => microtime(TRUE)`. Always a **wildcard `/*`** — the whole distribution.
8. Success → `notice` log with the returned invalidation ID and the matched/total tag counts. Any
   `\Throwable` → `error` log "CloudFront invalidation failed: @msg"; the exception is swallowed so a failed
   CloudFront call never breaks Drupal's cache clear.

Logs go to channel `cloudfront_invalidate_all`. Debug logging (when enabled) records the whitelist contents
and the tag list being processed — plain cache-tag names, no secrets.

## AWS credential model (security-relevant)

The module **does not accept, store, or log AWS credentials.** `CloudFrontClient` is constructed with only
`region` and `version`, so the AWS SDK resolves credentials from its default provider chain — environment
variables (`AWS_ACCESS_KEY_ID` / `AWS_SECRET_ACCESS_KEY`) or the EC2/ECS IAM instance-metadata role. Keep the
key/secret as secrets (env or IAM role), and scope the IAM policy to `cloudfront:CreateInvalidation` on the one
distribution (least privilege). TLS verification is left at the SDK default (enabled) — the client is not
configured with `verify => false`.

## Operational notes

- Wildcard invalidations are coarse and carry an **AWS cost** at high frequency (CloudFront bills per
  invalidation path beyond the monthly free tier). Tune the whitelist tightly and rely on the disabled flag
  when needed.
- Suited to **small sites only** (a few thousand URLs). Large sites should use Purge + `cloudfront_purger`
  with real tag-to-path mappings.
