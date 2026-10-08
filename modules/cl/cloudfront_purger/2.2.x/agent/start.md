<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CloudFront Purge — agent index

Provides a **Purge purger plugin** `cloudfront` that invalidates paths on an AWS CloudFront
distribution (via `aws/aws-sdk-php` `CreateInvalidation`). Supports `path`, `wildcardpath`,
`everything` invalidation types. Requires the **Purge** module; cache-**tag** invalidation is in the
`cloudfront_purger_tags` submodule (not here). No admin route of its own (`configure: null`) — the
purger is managed through Purge.

- **Configure it: settings keys, distribution id, AWS auth, region, disabled flag, add to Purge** →
  [configure/settings.md](configure/settings.md)
- **The purger plugin internals: types, invalidate() flow, path building, services** →
  [api/purger.md](api/purger.md)

Key facts:
- Purger plugin id: `cloudfront` (`@PurgePurger`), `multi_instance = FALSE`,
  types `{path, wildcardpath, everything}`.
- Config object `cloudfront_purger.settings`: `distribution_id`, `aws_key`, `aws_secret`,
  `disabled` (bool). Default: all empty, `disabled: true`.
- `disabled: true` → invalidations are marked SUCCEEDED **without** calling AWS (black hole).
- Credentials: config key/secret if set, else AWS SDK default chain (IAM role / env / profile). IAM
  needs `cloudfront:CreateInvalidation`.
- Client region default from service param `cloudfront_purger.cloudfront_client.options`
  (`ap-southeast-1`), overridable in `services.yml`.
- Add to Purge with `drush p:purger-add cloudfront`; queue paths (suggest `purge_queuer_url`).
- **AWS charges per invalidation.**
