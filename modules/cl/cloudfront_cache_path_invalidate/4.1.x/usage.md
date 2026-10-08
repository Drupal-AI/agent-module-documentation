Clears (invalidates) Amazon CloudFront edge-cache paths from Drupal — both automatically when configured entity types are created/updated/deleted, and manually via an admin form that submits arbitrary paths.

---

The module wraps the AWS SDK's CloudFront `createInvalidation` call (`cloudfront_cache_path_invalidate_url()`), reading AWS credentials from `settings.php` (`$settings['aws.distributionid'|'aws.region'|'aws.access_key'|'aws.secret_key']`) — never from module config. On `hook_entity_insert/update/delete` it looks up per-entity-type/bundle "groups" saved in `cloudfront_cache_path_invalidate.settings` and invalidates the entity's canonical alias (with language prefix and any Redirect module source paths) plus any extra paths you listed for that group; anonymous-triggered saves are skipped. A second admin form lets an operator paste path patterns (e.g. `/sector/*`) and invalidate them on demand. Both forms live under *Configuration > Web services*. The automatic-settings form (`AutoCloudfrontCacheSettingForm`) is gated by the restricted `cloudfront_cache_path_invalidate_permission`; the manual invalidate form (`CloudfrontCacheInvalidateForm`) is gated by the non-restricted `cloudfront_cache_path_invalidate_use_invalidate_url_form`. Successful and failed invalidations are logged to the `cloudfront_cache_path_invalidate` channel. Requires `aws/aws-sdk-php` `3.*`.

---

- Invalidate a CloudFront distribution's cache for a node's URL alias whenever the node is updated.
- Auto-invalidate on create/update/delete for specific content types (e.g. Article, Page).
- Invalidate additional listing paths (e.g. `/articles`) when a related entity changes.
- Manually purge CloudFront paths on demand from an admin form (e.g. `/sector/*`, `/state/*`).
- Wildcard-invalidate a whole section of the site (`/blog/*`) after a bulk content change.
- Clear cache for translated aliases with the correct language prefix.
- Also invalidate legacy URLs tracked by the Redirect module's source paths.
- Trigger invalidations for any bundled content entity type, not just nodes.
- Support subdirectory installs by prefixing the site base path to invalidated paths.
- Keep AWS credentials out of Drupal config by reading them from `settings.php`.
- Configure the target distribution ID and region per environment via `settings.php`.
- Restrict who can change automatic invalidation rules with a dedicated admin permission.
- Delegate on-demand cache clearing to editors via a separate form permission.
- Log every invalidation attempt (and AWS error) to the Drupal log for auditing.
- Group multiple entity-type/bundle rules on one settings form with add/remove controls.
- Invalidate menu-link changes by mapping them to their menu.
- Use IAM access keys scoped to `cloudfront:CreateInvalidation` for least privilege.
- Pair with a page/edge cache so content edits appear quickly on a CloudFront-fronted site.
