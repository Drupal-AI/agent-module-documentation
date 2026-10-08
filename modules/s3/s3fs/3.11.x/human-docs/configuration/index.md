# Configuration

S3 File System needs real setup before it does anything. The steps below follow
the order the module's own documentation recommends: credentials first, then
bucket and region, then the serving domain, then the big decision of whether to
take over the public/private file systems, and finally object behaviour and the
metadata cache.

The settings form lives at **Configuration → Media → S3 File System**
(`/admin/config/media/s3fs`, permission **Administer S3 File System**). Most keys
can also be set from the command line with `drush cset s3fs.settings <key>
<value>`, which is how the examples below are shown.

## 1. Credentials

S3 File System resolves AWS credentials in a fixed order, stopping at the first
that supplies them:

1. `$settings['s3fs.access_key']` and `$settings['s3fs.secret_key']` in
   `settings.php`.
2. **Key** module entities named in `s3fs.settings:keymodule.access_key_name` and
   `.secret_key_name` — consulted only when a key is still missing **and** the
   `key` module is enabled.
3. The AWS SDK's own default provider chain — an EC2/ECS instance or task role,
   `AWS_*` environment variables, or shared config files.

The preferred approach on AWS is **no keys at all**: let the instance role supply
them, so nothing sensitive lives in your codebase. Otherwise, store the keys as
Key entities so they never land in a config export. A typical Key-based setup:

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

If the SDK would otherwise hit the instance-metadata endpoint on every request,
you can enable credential caching with `use_credentials_cache` and
`credentials_cache_dir`.

## 2. Bucket and region

```bash
drush cset s3fs.settings bucket my-bucket -y
drush cset s3fs.settings region eu-north-1 -y
drush cset s3fs.settings use_https true -y
```

The bucket can instead be pinned per environment in `settings.php`:

```php
$config['s3fs.settings']['bucket'] = 'my-bucket-staging';
```

Optional folder-layout keys let several sites share one bucket, or separate public
and private files inside it:

| Key | Effect |
|---|---|
| `root_folder` | A prefix for everything — lets several sites share one bucket |
| `public_folder` | Prefix used for the public scheme (default `s3fs-public`) |
| `private_folder` | Prefix used for the private scheme (default `s3fs-private`) |

## 3. Serving domain

| Setting | Use |
|---|---|
| `use_cname` + `domain` | Serve through CloudFront, or a bucket named like a domain |
| `domain_root` | Map the domain to a specific path inside the bucket |
| `use_customhost` + `hostname` | Point at a non-AWS S3 service (`https://objects.example.com`) |
| `use_path_style_endpoint` | Path-style rather than virtual-hosted-style URLs (MinIO/Ceph) |
| `use_cssjs_host` + `cssjs_host` | Serve aggregated CSS/JS from a different host |
| `disable_cert_verify` | Skip TLS certificate verification — **local emulators only, never production** |
| `disable_version_sync` | For buckets that do not support `listObjectVersions` |

The `disable_cert_verify` option is exactly what it sounds like: it turns off TLS
peer verification so you can test against a local S3 emulator. Leave it off in
production — with it on, traffic to the bucket is no longer protected against
interception.

## 4. Taking over the public and private file systems

This is the switch that makes S3 File System replace Drupal's normal file
storage — and it is **not on the settings form**. The swap happens inside
`S3fsServiceProvider` when the container is built, so it can only be set in
`settings.php`:

```php
// settings.php
$settings['s3fs.use_s3_for_public']  = TRUE;   // public:// → S3
$settings['s3fs.use_s3_for_private'] = TRUE;   // private:// → S3
$settings['s3fs.upload_as_private']  = TRUE;   // optional: write new objects as private
```

After changing these, run `drush cr`, then check the site's status report — the
module reports the takeover state (OK or error) for both schemes.

**Get the order right.** Existing `public://` URLs keep working after takeover, but
they now resolve to objects in the bucket — which will not exist until you copy
your local files up. The safe sequence is:

```bash
# 1. Configure bucket + credentials, then build the metadata cache.
drush cset s3fs.settings bucket my-bucket -y
drush s3fs:refresh-cache

# 2. Copy existing local files up, while Drupal is still serving them locally.
drush s3fs:copy-local --condition=newer_size

# 3. Flip the takeover switches in settings.php (above), then rebuild caches.
drush cr

# 4. Refresh once more so the cache reflects the new layout, then verify.
drush s3fs:refresh-cache
```

Flipping takeover **before** copying leaves every existing file URL pointing at a
missing object, so images 404 until the copy finishes.

## 5. Object behaviour

| Setting | Meaning |
|---|---|
| `encryption` | Server-side encryption mode applied to every write |
| `cache_control_header` | The `Cache-Control` header sent on stored objects, e.g. `public, max-age=86400` |
| `presigned_urls` | Newline-separated `<timeout>\|<path regex>` rules — matching files get time-limited signed URLs |
| `saveas` | Path patterns forced to download rather than display inline |
| `torrents` | Path patterns served as torrents (a legacy S3 feature) |
| `redirect_styles_ttl` | TTL for image-style redirects to S3 (0 = no redirect caching) |
| `read_only` | Block all writes to the bucket |
| `ignore_cache` | Bypass the metadata cache — correct but slow, for debugging only |

For example:

```bash
drush cset s3fs.settings cache_control_header 'public, max-age=86400' -y
drush cset s3fs.settings presigned_urls "60|private-docs/.*" -y
drush cset s3fs.settings saveas "private-docs/.*" -y
```

Image styles get special handling: derivatives are generated once and then served
from S3, optionally as a redirect with the TTL you set in `redirect_styles_ttl`.

## 6. The metadata cache and its Drush commands

S3 has no cheap `stat()`. Drupal constantly asks whether a file exists, how big it
is, and whether a path is a directory — doing that over the network would be
unusable, so S3 File System mirrors every object's metadata in a database table
and answers those questions from there. The trade-off: anything that changes
objects **outside Drupal** (the AWS CLI, another application, S3 lifecycle rules)
is invisible until you refresh the cache.

**`drush s3fs:refresh-cache`** (aliases `s3fs-rc`, `s3fs-refresh-cache`) validates
your configuration, then rebuilds the metadata table by listing the bucket. Run it
after initial setup, a bulk upload done outside Drupal, restoring a bucket, or
changing any of the folder keys. The same operation is the **Refresh file metadata
cache** action on `/admin/config/media/s3fs/actions`.

**`drush s3fs:copy-local`** (aliases `s3fs-cl`, `s3fs-copy-local`) copies your
existing local files up into the bucket:

```bash
drush s3fs:copy-local                      # both schemes, copy everything
drush s3fs:copy-local --scheme=public      # public:// only
drush s3fs:copy-local --condition=newer    # skip files already current in the bucket
```

| Option | Values | Meaning |
|---|---|---|
| `--scheme` | `all` (default), `public`, `private` | Which local file system to copy |
| `--condition` | `always` (default), `newer`, `size`, `newer_size` | When to upload a given file |

`always` re-uploads everything unconditionally — safe but slow on a large tree; use
`newer_size` for repeat runs so only changed files move.

## 7. Validate

The **Validate** button on `/admin/config/media/s3fs/actions` checks your live
configuration against the bucket. If refresh or validate throws an error, it is
almost always bad credentials, the wrong region, or a bucket policy denying
`ListBucket`. Watch the module's log channel while you debug:

```bash
drush watchdog:show --type=s3fs --count=50
drush cget s3fs.settings                    # effective config, including settings.php overrides
```
