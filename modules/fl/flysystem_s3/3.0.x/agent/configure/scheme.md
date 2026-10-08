<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Define an S3 scheme (settings.php)

There is **no Drupal config UI** (`configure` is null). You declare Flysystem schemes in
`settings.php`; the Flysystem module turns each into a stream wrapper. This module supplies the
`driver: s3` implementation.

```php
$schemes = [
  's3' => [                      // <- the stream-wrapper scheme name => s3://
    'driver' => 's3',            // <- selects this module's adapter (@Adapter id="s3")
    'config' => [
      'key'    => '[your key]',  // omit key + secret to use an IAM role instead
      'secret' => '[your secret]',
      'region' => 'eu-west-1',   // AWS region ID (not the display name)
      'bucket' => 'my-bucket',

      // Optional:
      // 'options'  => ['ACL' => 'public-read', 'StorageClass' => 'REDUCED_REDUNDANCY'],
      // 'protocol' => 'https',            // autodetected from the request if unset
      // 'prefix'   => 'an/optional/prefix', // directory prefix for all objects
      // 'cname'    => 'static.example.com', // custom domain for URL generation
      // 'cname_is_bucket' => TRUE,        // FALSE => include bucket in the path
      // 'endpoint' => 'https://s3.example.com', // S3-compatible 3rd-party providers
      // 'public'   => TRUE,               // link directly to public objects
      // 'cors'     => TRUE,               // enable direct browser->S3 upload (see cors-upload.md)
    ],
    'cache' => TRUE,             // metadata cache to speed up lookups
  ],
];
$settings['flysystem'] = $schemes;
```

## Key config keys

| Key | Purpose |
|---|---|
| `region` | AWS **region id** (`us-east-1`, `eu-west-1`, …). Defaults to `us-east-1`. |
| `bucket` | Bucket name. |
| `key` / `secret` | Static IAM user credentials. **Omit both** to fall back to an IAM role / instance profile (credentials cached via `AwsCacheAdapter`). |
| `prefix` | Path prefix inside the bucket for all files. |
| `public` | `TRUE` = generate direct object URLs (public bucket); `FALSE` = serve via Drupal (download URL). |
| `cname` / `cname_is_bucket` | Custom URL host; `cname_is_bucket=FALSE` puts the bucket in the path. |
| `endpoint` | Alternate API endpoint for non-AWS S3 providers. |
| `options` | Passed to the AWS adapter, e.g. default `ACL`, `StorageClass`, `ContentType`. |
| `cors` | Enables direct CORS upload (also needs the permission + bucket CORS). |
| `use_accelerate_endpoint`, `use_dual_stack_endpoint`, `use_path_style_endpoint`, `bucket_endpoint` | Passed through to the S3Client. |

The S3 client is always built with `version: latest`. `protocol` defaults to the current
request scheme. After editing settings.php run `drush cr`. Use the file field / default file
scheme settings (core, or Flysystem's tooling) to point content at the `s3://` wrapper.

## Notes
- `region` must be the **id**, not the display name (see the README's region table).
- If the bucket is unreachable, `getAdapter()` logs the error and returns a `MissingAdapter`;
  `ensure()` reports "Bucket %bucket does not exist." to status checks.
- Credentials in settings.php are plaintext — keep settings.php out of the webroot/VCS and
  prefer IAM roles where possible.
