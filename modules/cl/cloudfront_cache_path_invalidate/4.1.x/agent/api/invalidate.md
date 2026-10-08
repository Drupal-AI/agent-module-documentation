# Cloudfront Cache Path Invalidate — programmatic API

## `cloudfront_cache_path_invalidate_url(array $paths): array`

Global function in `cloudfront_cache_path_invalidate.module`. Sends one CloudFront invalidation batch
for the given paths.

```php
[$status, $message] = cloudfront_cache_path_invalidate_url(['/articles', '/articles/my-node', '/blog/*']);
// $status: TRUE on success, FALSE on failure/misconfig.
// $message: error text when $status is FALSE.
```

- Aborts (returns `[FALSE, msg]`) if `aws.region` or `aws.distributionid` settings are unset.
- Builds an `Aws\CloudFront\CloudFrontClient` with `version=latest`, the configured region, and (if
  present) the `aws.access_key`/`aws.secret_key` credentials.
- `CallerReference` = `md5(implode(',', $paths)) . time()` (unique per call).
- Calls `createInvalidation` with `DistributionId` and the paths as `Items`/`Quantity`.
- On `AwsException`: logs the message to the `cloudfront_cache_path_invalidate` channel, shows a
  messenger error, and returns `[FALSE, message]`.

Paths must be CloudFront invalidation paths (start with `/`; `*` wildcard allowed). There is no Drush
command — call this function from custom code, or use the admin forms. Note CloudFront bills
invalidation paths beyond the monthly free allotment, so avoid unbounded automated wildcard purges.
