# Installation

## Requirements

- **Drupal 9.3+, 10 or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **S3 File System** (`s3fs`) — configured and working.
- **Stage File Proxy** (`stage_file_proxy`).

Both dependencies are enabled automatically if you install this module with
Composer. There are no submodules and no third-party PHP libraries beyond what
s3fs itself pulls in.

## Install with Composer

From the project root:

```bash
composer require drupal/s3fs_file_proxy_to_s3 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in `s3fs`,
`stage_file_proxy` and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/s3fs_file_proxy_to_s3 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the modules

```bash
drush en s3fs stage_file_proxy s3fs_file_proxy_to_s3 -y
```

## Turn on S3-for-public and provide staging credentials

The module's overriding behaviour only activates when the s3fs public-file
takeover is on. Set this in `settings.php`:

```php
$settings['s3fs.use_s3_for_public'] = TRUE;
```

Supply the S3 credentials and bucket for the **staging** bucket through the normal
s3fs settings (keys in `settings.php`, not exported config). Do not commit real
keys.

## Point Stage File Proxy at production

Configure the Stage File Proxy **origin** to your production site's URL. The fetch
manager builds each remote URL from that origin plus the requested public path — it
never fetches a URL taken from the incoming request, so there is no arbitrary-URL
fetch surface.

## Verify it worked

This module has no admin page. To confirm it is active, request a public file (for
example an image) on the staging site that exists on production but has not yet
been copied to the staging bucket. The first request should transparently fetch it
from production and store it in the staging bucket; the file should then load
normally, and subsequent requests are served straight from S3.

Keep in mind this is a staging / pre-production convenience only — it is not meant
for production use.
