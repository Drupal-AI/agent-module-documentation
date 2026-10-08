# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- **S3 File System** (`s3fs`) — installed, configured with your AWS credentials
  and bucket, and working. Grant Plus is an extension to it, not a standalone
  module.

There are no submodules and no third-party PHP library requirements of its own.

> **A note on security coverage:** at the documented version this module is *not*
> covered by Drupal's security advisory policy (`security_advisory_coverage:
> not-covered`). That does not mean it is unsafe — its behaviour is a narrow S3 ACL
> grant — but it is worth knowing when weighing it for a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/s3fs_grant_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/s3fs_grant_plus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en s3fs_grant_plus -y
```

If s3fs is not already enabled, Drush enables it as a dependency — but you still
need to configure s3fs (bucket, region, credentials) before Grant Plus has
anything to grant against.

## Verify it worked

After enabling, open the S3 File System settings form at
`/admin/config/media/s3fs`. Grant Plus adds a new field for the reader account's
ID — its presence confirms the module is active. See
[Configuration](../configuration/index.md) for filling it in. Once set, upload a
new file through Drupal and check in the AWS console that the object carries a read
grant for the account you named.
