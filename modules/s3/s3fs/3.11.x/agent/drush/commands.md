<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands and the metadata cache

Registered the classic way via `drush.services.yml` →
`Drupal\s3fs\Drush\Commands\S3fsDrushCommands` (annotation-style `@command`).

## `s3fs:refresh-cache` (aliases `s3fs-rc`, `s3fs-refresh-cache`)

```bash
drush s3fs:refresh-cache
```

Validates the configuration first (`S3fsService::validate()`); on failure it logs each error and
throws *"Unable to validate your s3fs configuration settings…"* without touching the cache. On
success it runs `s3fs.refresh_cache_batch`, which lists the bucket and rebuilds the local metadata
table.

**Why the cache exists:** S3 has no cheap `stat()`. Drupal calls `file_exists()`, `filesize()`,
`is_dir()` constantly, and doing that over the network would be unusable — so object metadata is
mirrored in a database table and answered from there. The trade-off: anything that changes objects
**outside Drupal** (aws-cli, another app, lifecycle rules) is invisible until you refresh.

Run it after: the initial setup, a bulk upload done outside Drupal, restoring a bucket, or
changing `root_folder`/`public_folder`/`private_folder`.

The same operation is available as *Refresh file metadata cache* on
`/admin/config/media/s3fs/actions`.

`ignore_cache: true` in `s3fs.settings` bypasses the table entirely — every stat hits S3. Correct
but slow; use it only to prove a cache-staleness theory, then turn it back off.

## `s3fs:copy-local` (aliases `s3fs-cl`, `s3fs-copy-local`)

```bash
drush s3fs:copy-local                      # both schemes, copy everything
drush s3fs:copy-local --scheme=public      # public:// only
drush s3fs:copy-local --scheme=private     # private:// only
drush s3fs:copy-local --condition=newer    # skip files already current in the bucket
```

| Option | Values | Meaning |
|---|---|---|
| `--scheme` | `all` (default), `public`, `private` | Which local file system to copy |
| `--condition` | `always` (default), `newer`, `size`, `newer_size` | When to upload a given file |

The condition maps onto `upload_conditions`: `newer` compares modification times, `size` compares
byte sizes, `newer_size` requires both. `always` re-uploads unconditionally — safe but slow on a
large tree; use `newer_size` for repeat runs.

The command prints two warnings by design: read the *"Copy local files to S3"* section of
README.txt, and note that copying is only useful if you have enabled (or are about to enable)
`$settings['s3fs.use_s3_for_public']` / `['s3fs.use_s3_for_private']`.

## The correct migration order

```bash
# 1. Configure bucket + credentials, validate.
drush cset s3fs.settings bucket my-bucket -y
drush s3fs:refresh-cache

# 2. Copy the existing local files up, while Drupal still serves them locally.
drush s3fs:copy-local --condition=newer_size

# 3. Flip the takeover in settings.php:
#    $settings['s3fs.use_s3_for_public']  = TRUE;
#    $settings['s3fs.use_s3_for_private'] = TRUE;
drush cr

# 4. Refresh once more so the cache reflects the new scheme layout, then verify.
drush s3fs:refresh-cache
drush php:eval 'print \Drupal::service("file_url_generator")->generateAbsoluteString("public://somefile.jpg");'
```

Flipping the takeover **before** copying leaves every existing file URL pointing at an object that
does not exist yet — images 404 until the copy finishes.

## Troubleshooting

```bash
drush watchdog:show --type=s3fs --count=50      # module log channel
drush cget s3fs.settings                        # effective config (incl. settings.php overrides)
drush php:eval 'var_dump(\Drupal::service("s3fs")->validate(\Drupal::config("s3fs.settings")->get()));'
```

| Symptom | Usual cause |
|---|---|
| Refresh throws the validation error | Bad credentials/region/bucket, or a bucket policy denying `ListBucket` |
| Files exist in S3 but Drupal says they do not | Stale metadata cache — refresh |
| New uploads work, old files 404 | Takeover enabled before `copy-local` ran |
| Everything is slow | `ignore_cache` left on |
| Works on CLI, fails in web (or vice versa) | Credentials coming from a shell-only env var / instance role difference |
