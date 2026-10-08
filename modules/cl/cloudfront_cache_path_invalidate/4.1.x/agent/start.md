# Cloudfront Cache Path Invalidate — agent index

Invalidates Amazon CloudFront edge-cache paths from Drupal, automatically on entity
insert/update/delete and manually via an admin form. AWS credentials come from `settings.php`, not
config. Requires `aws/aws-sdk-php` `3.*`. Config route
`cloudfront_cache_path_invalidate.admin_cloudfront_invalidate_url`. No Drush, no config schema.

- **AWS `settings.php` keys, the two admin forms/routes, `cloudfront_cache_path_invalidate.settings`
  structure, entity-hook behavior, permissions** → [configure/settings.md](configure/settings.md)
- **Programmatic invalidation: `cloudfront_cache_path_invalidate_url($paths)`** →
  [api/invalidate.md](api/invalidate.md)

Key facts:
- Credentials: `$settings['aws.distributionid' | 'aws.region' | 'aws.access_key' | 'aws.secret_key']`.
- Auto-invalidation reads per-group rules from config; manual form takes raw path patterns.
- Permissions: `cloudfront_cache_path_invalidate_permission` (restricted, settings form) and
  `cloudfront_cache_path_invalidate_use_invalidate_url_form` (NOT restricted, manual invalidate form).
- Every invalidation POSTs to AWS CloudFront `createInvalidation` for the configured distribution.
