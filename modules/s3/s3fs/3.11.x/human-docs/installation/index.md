# Installation

## Requirements

- **A supported Drupal core version — check this carefully.** This release has an
  unusually narrow constraint:
  `>=8.8 <10.7 || >=11.0 <11.2 || >=11.2.3 <11.4.0 || >=11.4.3 <11.5`. Drupal
  10.7+ and 11.4.0–11.4.2 are deliberately excluded, so if you are mid-way through
  a core upgrade, confirm your target version is inside that range — the module
  will block the update otherwise.
- **PHP 7.1 or 8.x** (`^7.1 || ^8.0`).
- **The AWS SDK for PHP**, `aws/aws-sdk-php ^3.18` — Composer installs this
  automatically.
- **PHP configured with `allow_url_fopen = On`** in `php.ini`, otherwise PHP
  cannot open files that live in your S3 bucket.
- **The cURL PHP extension** (`php-curl` / `php5-curl`) so the SDK can talk to S3.
  Most hosts already have it.

There are no dependent Drupal modules and no submodules. The **Key** module is an
optional, suggested companion — it lets you store the AWS access/secret keys as
Key entities instead of in `settings.php`.

## Install with Composer

From the project root:

```bash
composer require drupal/s3fs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AWS SDK and
update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/s3fs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en s3fs -y
```

Enabling the module does **not** move any files or change how they are served on
its own — it simply makes the `s3://` scheme and the settings form available. The
real work happens in [Configuration](../configuration/index.md).

## Verify it worked

After you have entered a bucket and credentials (see Configuration), the fastest
sanity check is the **Validate** button on the actions form at
`/admin/config/media/s3fs/actions`, which tests your settings against the live
bucket. From Drush you can then confirm the stream wrapper is working end to end:

```bash
drush s3fs:refresh-cache
drush php:eval 'var_dump(file_put_contents("s3://test.txt", "hello"));'
drush php:eval 'print file_get_contents("s3://test.txt");'
```

A failure here is almost always credentials, region, or a bucket policy. The
module logs to the `s3fs` channel, so `drush watchdog:show --type=s3fs` is your
first stop when something is wrong.
