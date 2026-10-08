<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CloudFront Purge provides an AWS CloudFront purger plugin for the Purge module, so Drupal can invalidate paths (and wildcard paths, or everything) on a CloudFront distribution used as a reverse proxy / CDN in front of the site.

---

The module registers a Purge **purger** plugin (`cloudfront`) that turns Purge invalidations into AWS CloudFront `CreateInvalidation` API calls via the `aws/aws-sdk-php` library. It supports `path`, `wildcardpath`, and `everything` invalidation types: path invalidations become `/path` entries, an "everything" invalidation becomes `/*`, and unsupported types are marked NOT_SUPPORTED. Configuration lives in `cloudfront_purger.settings` — the CloudFront **Distribution ID** (required to actually purge), optional AWS **key/secret**, and a **`disabled`** flag that, when true, "black-holes" invalidations (marks them SUCCEEDED without calling AWS — handy for non-production). Credentials are resolved by a client factory: if `aws_key`/`aws_secret` are set in config they are used, otherwise the AWS SDK's default chain applies (IAM roles, environment variables, `~/.aws/credentials`). The client region defaults to a service parameter (`cloudfront_purger.cloudfront_client.options`, region `ap-southeast-1`) and can be overridden in `services.yml`. Cache **tag** invalidation is not in this base module — it is provided by the bundled `cloudfront_purger_tags` submodule. To actually run, the purger must be added to Purge (e.g. `drush p:purger-add cloudfront`) and paths must be queued (the `purge_queuer_url` module is suggested). **Note:** AWS bills per invalidation, so estimate cost before use.

---

- Invalidate a specific page URL on CloudFront when its Drupal node is updated.
- Purge a set of paths from the CDN after a content deployment.
- Use CloudFront as a full-site reverse proxy and clear it from Drupal on changes.
- Wildcard-invalidate a section (e.g. `/blog/*`) after bulk edits.
- Invalidate everything (`/*`) on the distribution after a major site change.
- Integrate CDN cache clearing into Purge's queue/processor pipeline.
- Automatically collect URLs to purge with the suggested `purge_queuer_url` module.
- Run a "black-hole" (disabled) purger in staging so invalidations are marked done without AWS calls.
- Authenticate to AWS via an IAM role on EC2/ECS without storing keys in Drupal config.
- Authenticate via environment variables or an `~/.aws/credentials` profile instead of config.
- Store the AWS key/secret in `cloudfront_purger.settings` for simple setups.
- Override the CloudFront client region via a `services.yml` parameter.
- Set the distribution id in `settings.php` (kept out of exported config) for per-environment values.
- Export the distribution id as part of site config for deployment.
- Clear CDN caches as part of a scheduled cron purge run.
- Directly invalidate a path for testing with `drush p:invalidate path /some/page`.
- Add cache-tag-based invalidation by enabling the `cloudfront_purger_tags` submodule.
- Prioritize CDN invalidation of high-traffic URLs after publishing.
- Keep CloudFront and Drupal caches in sync so visitors never see stale pages.
- Combine with Purge's diagnostics to monitor purger health and configuration.
- Limit invalidation volume (and AWS cost) by queueing only changed paths.
