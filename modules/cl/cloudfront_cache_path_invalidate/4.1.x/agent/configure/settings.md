# Cloudfront Cache Path Invalidate — configuration

## AWS credentials (settings.php only — never module config)

```php
$settings['aws.distributionid'] = 'ABCD1234EFGH7';
$settings['aws.region']         = 'eu-west-2';
$settings['aws.access_key']     = 'AKIA...';
$settings['aws.secret_key']     = '...';
```

Read via `Settings::get()` in `cloudfront_cache_path_invalidate_url()`. If `aws.region` or
`aws.distributionid` is unset, invalidation aborts with a message. If access/secret keys are omitted,
the AWS SDK falls back to its default credential chain (IAM role, env, etc.). IAM policy needs
`cloudfront:CreateInvalidation` on the distribution.

## Routes / forms / permissions (`*.routing.yml`, `*.permissions.yml`)

| Route / path | Form | Permission | `restrict access` |
|---|---|---|---|
| `...admin_cloudfront_invalidate_url` — `/admin/config/services/cloudfront-invalidate-url` | `CloudfrontCacheInvalidateForm` (manual) | `cloudfront_cache_path_invalidate_use_invalidate_url_form` | **no** |
| `...auto_admin_cloudfront_url_invalidate_setting` — `/admin/config/services/auto-cloudfront-cache-entities` | `AutoCloudfrontCacheSettingForm` (auto rules) | `cloudfront_cache_path_invalidate_permission` | yes |

The manual form takes a textarea of paths (each must start with `/`), trims them, and calls
`cloudfront_cache_path_invalidate_url()`. Note the manual-form permission is **not** `restrict access:
true`, so it can be granted to lower-trust roles; holders can trigger arbitrary CloudFront
invalidations (wildcards allowed) against the site's distribution using the site's AWS credentials —
scope this permission and the IAM key deliberately. (The destination is fixed to the site's own distribution.)

## Auto-invalidation config (`cloudfront_cache_path_invalidate.settings`)

`AutoCloudfrontCacheSettingForm` stores parallel indexed arrays (one slot per "group"), no config
schema file ships:

| Key | Meaning |
|---|---|
| `ecgroupcount` | Number of active groups. |
| `ecentitytype[]` | Entity type id per group (only types with a bundle entity type). |
| `ecentitytypebundle[]` | Bundle id per group. |
| `detail_page[]` | Bool: also invalidate the `/{bundle}/{id}` detail alias. |
| `ec_cloudfront_url[]` | Newline-separated extra paths to invalidate for that group. |

The form supports Add/Remove group buttons (AJAX). Config is deleted on uninstall.

## Entity-hook behavior (`.module`)

`hook_entity_insert/update/delete` -> `cloudfront_cache_path_invalidate_process_entity()`:
- Skips when the current user is anonymous.
- Matches the entity's type/bundle against saved groups; for a match, collects: the configured extra
  paths, the entity's canonical path alias (with language prefix for non-default languages, base-path
  prefixed for subdirectory installs), Redirect module source paths (if `redirect` is enabled), and the
  detail-page alias when `detail_page` is set.
- Calls `cloudfront_cache_path_invalidate_url($paths)` and logs success/failure.
- `menu_link_content` entities are remapped to their menu name for matching.
