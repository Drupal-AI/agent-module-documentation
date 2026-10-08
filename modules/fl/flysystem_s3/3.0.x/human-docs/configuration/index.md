# Configuration

Flysystem Amazon S3 has **no admin settings form**. You configure it by adding one or
more storage schemes to your site's `settings.php` under `$settings['flysystem']`.
Each scheme becomes a stream wrapper you can then use as Drupal's file storage.

## Declare an S3 scheme in settings.php

Add a block like this to `settings.php` (or, better, a non‑committed
`settings.local.php` that it includes):

```php
$settings['flysystem'] = [
  's3' => [                        // the stream-wrapper name -> gives you s3://
    'driver' => 's3',              // selects this module's S3 adapter
    'config' => [
      'region' => 'eu-west-1',     // an AWS region ID, not the display name
      'bucket' => 'my-bucket',

      // Credentials — see "Handling credentials safely" below.
      'key'    => getenv('AWS_ACCESS_KEY_ID'),
      'secret' => getenv('AWS_SECRET_ACCESS_KEY'),

      // Optional extras (all can be omitted):
      // 'prefix'   => 'sites/default/files', // put all objects under a folder
      // 'public'   => TRUE,                  // link directly to public objects
      // 'cname'    => 'static.example.com',  // serve via a custom domain / CDN
      // 'endpoint' => 'https://s3.example.com', // for non-AWS S3 providers
      // 'options'  => ['ACL' => 'public-read'], // default object ACL / storage class
      // 'cors'     => TRUE,                  // enable direct browser uploads (below)
    ],
    'cache' => TRUE,               // cache object metadata for faster lookups
  ],
];
```

After editing `settings.php`, run `drush cr` so Drupal picks up the new scheme.

### The main configuration keys

| Key | What it does |
|-----|--------------|
| `region` | The AWS **region ID** (`us-east-1`, `eu-west-1`, …) — the code, not the friendly name. Defaults to `us-east-1`. |
| `bucket` | The S3 bucket name. |
| `key` / `secret` | Static credentials. **Omit both** to use an AWS IAM role instead (recommended — see below). |
| `prefix` | A path prefix so all objects live inside a folder within the bucket. |
| `public` | `TRUE` generates direct object URLs (public bucket); `FALSE` serves files through Drupal so access control still applies. |
| `cname` / `cname_is_bucket` | Serve files from a custom host (CDN). Set `cname_is_bucket` to `FALSE` to include the bucket name in the path. |
| `endpoint` | An alternate API endpoint for S3‑compatible providers (MinIO, DigitalOcean Spaces, Wasabi, …). |
| `options` | Extra defaults passed to S3, such as `ACL` (e.g. `public-read`) or `StorageClass` (e.g. `REDUCED_REDUNDANCY`). |
| `use_accelerate_endpoint`, `use_dual_stack_endpoint`, `use_path_style_endpoint` | Passed straight through to the S3 client for special routing needs. |

## Handling credentials safely

**Never hard‑code AWS keys in a file you commit to version control.** Two safe
options:

- **IAM role (best on AWS‑hosted sites).** Leave out `key` and `secret` entirely. The
  AWS SDK then obtains credentials from the instance's IAM role, and the module caches
  them through Drupal's cache to avoid hammering the metadata endpoint. Nothing secret
  ever lives in your files.
- **Environment variables.** If you must use a static key/secret, read them from the
  environment as shown above (`getenv('AWS_ACCESS_KEY_ID')` /
  `getenv('AWS_SECRET_ACCESS_KEY')`) and set those variables outside your codebase.

  > **Using DDEV?** Store the values with DDEV's dotenv helper rather than committing
  > them:
  > ```bash
  > ddev dotenv set .ddev/.env --aws-access-key-id=AKIA... --aws-secret-access-key=...
  > ddev restart
  > ```
  > This makes `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` available inside the
  > web container. Keep `.ddev/.env` out of version control.

Keep `settings.php` itself outside the web root and out of your repository whenever it
holds anything sensitive.

## Point Drupal at the S3 scheme

With the scheme defined and caches cleared, the `s3://` stream wrapper becomes an
option wherever Drupal chooses file storage:

- **A single field** — on a file or image field's storage settings, choose the S3
  scheme as its upload destination.
- **Site‑wide default** — set the default download method / file scheme to `s3://` so
  new uploads go to S3 automatically.

The Flysystem module provides tooling to verify a scheme is reachable; if the bucket
cannot be reached, the module degrades gracefully and logs an error rather than
breaking the site.

## Direct browser‑to‑S3 (CORS) uploads

For large files you can let uploads travel straight from the browser to S3, skipping
PHP and the web server's upload size limits. Three things must all be true:

1. **Enable CORS on the scheme.** Add `'cors' => TRUE` to the scheme's `config` block
   in `settings.php` (see above), and `drush cr`.
2. **Add CORS rules to the bucket.** The bucket must allow your site's origin. The
   module ships an example policy, `s3-cors-example.json`, that permits the needed
   methods (`GET`/`PUT`/`POST`/`DELETE`) and headers; apply it with the AWS CLI, e.g.
   `aws s3api put-bucket-cors …`.
3. **Grant the permission.** Give the relevant roles the **Use S3 CORS upload**
   permission at **People → Permissions**.

When all three line up and a file/image field targets the CORS‑enabled scheme, the
module attaches JavaScript that signs the upload and sends the file directly to S3,
then registers the resulting file with Drupal. If any of the three conditions is
missing, uploads simply fall back to the normal server‑side path.
