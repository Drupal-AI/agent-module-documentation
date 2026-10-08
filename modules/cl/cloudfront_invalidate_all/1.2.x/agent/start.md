<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CloudFront Invalidate All (cloudfront_invalidate_all) — agent index

Invalidates an **entire AWS CloudFront distribution** (a wildcard `/*` invalidation) whenever Drupal
invalidates one of a **whitelisted set of cache tags**. A deliberately simple bridge for small sites — no
tag-to-path mapping. Package `Purge`. Core `^10 || ^11`. License GPL-2.0-or-later. Installed **1.2.0**
(version dir `1.2.x`).

> Maintainer marks this **obsolete** (development status Obsolete, maintenance status Unsupported): since
> April 2026 CloudFront supports cache-based invalidation, and the recommended path is the standard **Purge**
> module with `cloudfront_purger:^2.2`.

## Dependencies

- **No Drupal module dependencies.**
- PHP library: **`aws/aws-sdk-php` `^3.0`** (`composer.json`) — the AWS SDK for PHP.

## What it provides (from source)

- **Cache-tags-invalidator service** `cloudfront_invalidate_all.invalidator`
  (`src/CloudFrontInvalidator.php`, `final class` implementing `CacheTagsInvalidatorInterface`, tagged
  `cache_tags_invalidator`). Core calls its `invalidateTags()` on every cache-tag invalidation; when the
  gating conditions pass it fires a single wildcard `/*` `createInvalidation` on the configured distribution.
- **Settings form + route** `cloudfront_invalidate_all.settings` →
  `/admin/config/services/cloudfront-invalidate-all`
  (`src/Form/CloudFrontInvalidateAllSettingsForm.php`, a `ConfigFormBase`), guarded by
  `_permission: 'administer cloudfront invalidate all'`, `_admin_route: TRUE`.
- **Permission** (`.permissions.yml`): `administer cloudfront invalidate all` (`restrict access: true`).
- **Menu link** (`.links.menu.yml`) under Configuration › Web services.
- **Config** `cloudfront_invalidate_all.settings` (schema in `config/schema/`, defaults in
  `config/install/`): `distribution_id` (string), `region` (string, default `us-east-1`),
  `disabled` (bool, **ships `true`**), `whitelist` (sequence of tag-prefix strings, default
  `['node_list', 'node:']`), `debug` (bool).
- No `.install`, no `.module`, no hooks, no Drush commands, no templates, no libraries.

## Key behaviors (see config/settings.md)

- **AWS credentials are never stored or entered in Drupal.** The `CloudFrontClient` is built with only
  `region` + `version: latest`; credentials come from the AWS SDK default chain (env vars / IAM instance
  role). This is a security positive — no key/secret in config, logs, or JS.
- **Ships disabled** (`disabled: true`): nothing is sent to CloudFront until an admin unchecks the disable box.
- The tag filter is an **allow-list (whitelist)**, not a block-list: only tags whose string *begins with* a
  configured prefix trigger an invalidation; an empty whitelist means nothing ever fires.

## Solution docs

- **Settings form, config keys, whitelist matching, the invalidation call, AWS credential model, debug
  logging** → [config/settings.md](config/settings.md)
