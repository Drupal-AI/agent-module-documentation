<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setup: bucket, credentials, takeover

## Install

```bash
composer require drupal/s3fs      # pulls aws/aws-sdk-php ^3.18
drush en s3fs -y
```

Check the narrow core constraint first — this release supports
`>=8.8 <10.7 || >=11.0 <11.2 || >=11.2.3 <11.4.0 || >=11.4.3 <11.5`.

## 1. Credentials

Resolution order in `S3fsService::getAmazonS3Client()`:

1. `$settings['s3fs.access_key']` and `$settings['s3fs.secret_key']` (settings.php)
2. Key module entities named in `s3fs.settings:keymodule.access_key_name` / `.secret_key_name`
   (only consulted when a key is still missing **and** the `key` module is enabled)
3. The AWS SDK's default provider chain — instance/task role, `AWS_*` env vars, shared config
   files (`~/.aws/config`, unless `disable_shared_config_files` is on, or a
   `credentials_file` path is set)

Preferred on AWS: no keys at all, let the instance role supply them. Otherwise use Key entities so
nothing lands in config exports:

```bash
ddev dotenv set .ddev/.env --aws-access-key=AKIA... --aws-secret-key=...
ddev restart
drush en key -y
drush key:save s3_access --label='S3 access key' --key-type=authentication \
  --key-provider=env --key-provider-settings='{"env_variable":"AWS_ACCESS_KEY"}' --key-input=none -y
drush key:save s3_secret --label='S3 secret key' --key-type=authentication \
  --key-provider=env --key-provider-settings='{"env_variable":"AWS_SECRET_KEY"}' --key-input=none -y
drush cset s3fs.settings keymodule.access_key_name s3_access -y
drush cset s3fs.settings keymodule.secret_key_name s3_secret -y
```

Optional credential caching: `use_credentials_cache` + `credentials_cache_dir` (useful when the
SDK would otherwise hit the instance-metadata endpoint on every request).

## 2. Bucket and region

```bash
drush cset s3fs.settings bucket my-bucket -y
drush cset s3fs.settings region eu-north-1 -y
drush cset s3fs.settings use_https true -y
```

The bucket may instead be pinned per-environment in `settings.php`:

```php
$config['s3fs.settings']['bucket'] = 'my-bucket-staging';
```

Folder layout keys — all optional:

| Key | Effect |
|---|---|
| `root_folder` | Prefix for everything; lets several sites share one bucket |
| `public_folder` | Prefix used for the public scheme (default `s3fs-public`) |
| `private_folder` | Prefix used for the private scheme (default `s3fs-private`) |

## 3. Serving domain

| Setting | Use |
|---|---|
| `use_cname` + `domain` | Serve through CloudFront or a bucket named like a domain |
| `domain_root` | Map the domain to a specific path inside the bucket |
| `use_customhost` + `hostname` | Point at a non-AWS S3 service (`https://objects.example.com`) |
| `use_path_style_endpoint` | Path-style instead of virtual-hosted-style URLs (MinIO/Ceph) |
| `use_cssjs_host` + `cssjs_host` | Serve aggregated CSS/JS from a different host |
| `disable_cert_verify` | Skip TLS verification — local emulators only, never production |
| `disable_version_sync` | For buckets without `listObjectVersions` |

## 4. Taking over public/private files

This is **not** in the settings form — it is `settings.php`, because the swap happens in
`S3fsServiceProvider` at container build:

```php
// settings.php
$settings['s3fs.use_s3_for_public']  = TRUE;   // public:// → S3
$settings['s3fs.use_s3_for_private'] = TRUE;   // private:// → S3
$settings['s3fs.upload_as_private']  = TRUE;   // optional: write new objects private
```

After changing these: `drush cr`, then check the status report — `hook_requirements()` reports the
takeover state (OK/error) for both schemes.

With takeover **off**, S3 is available only through the explicit `s3://` scheme (e.g. choose it as
a field's upload destination). With it on, existing `public://` URIs keep working but resolve to
the bucket — which is why you must copy the existing files first
(see [../drush/commands.md](../drush/commands.md)).

## 5. Object behaviour

| Setting | Meaning |
|---|---|
| `encryption` | Server-side encryption mode applied to every write |
| `cache_control_header` | `Cache-Control` sent on stored objects, e.g. `public, max-age=300` |
| `presigned_urls` | Newline-separated `<timeout>\|<path regex>` rules — matching files get time-limited signed URLs |
| `saveas` | Newline-separated path patterns forced to download rather than render inline |
| `torrents` | Path patterns served as torrents (legacy S3 feature) |
| `redirect_styles_ttl` | TTL for image-style redirects to S3 (0 = no redirect caching) |
| `read_only` | Block all writes to the bucket |
| `ignore_cache` | Bypass the metadata cache — correct but slow, for debugging only |

```bash
drush cset s3fs.settings cache_control_header 'public, max-age=86400' -y
drush cset s3fs.settings presigned_urls "60|private-docs/.*" -y
drush cset s3fs.settings saveas "private-docs/.*" -y
```

## 6. Validate

The actions form at `/admin/config/media/s3fs/actions` has a **Validate** button that checks the
configuration against the live bucket. Then:

```bash
drush s3fs:refresh-cache            # build the metadata cache
drush php:eval 'var_dump(file_put_contents("s3://test.txt", "hello"));'
drush php:eval 'print file_get_contents("s3://test.txt");'
drush php:eval 'var_dump(\Drupal::service("file_url_generator")->generateAbsoluteString("s3://test.txt"));'
```

A failure here is almost always credentials, region, or a bucket policy — the module logs to the
`s3fs` channel (`drush watchdog:show --type=s3fs`).
