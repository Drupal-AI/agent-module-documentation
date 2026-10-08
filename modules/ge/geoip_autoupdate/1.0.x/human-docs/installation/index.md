# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **GeoIP** module (`geoip`) — a hard dependency. Install it alongside this
  module (`drupal/geoip`) if you don't have it yet.
- A configured **private filesystem**. Set `$settings['file_private_path']` in
  `settings.php` and make sure that directory is writable — the database is stored
  under `private://`.
- The PHP **`phar`** extension, which the module uses to extract MaxMind's
  `.tar.gz` archive. This is enabled in most PHP builds.
- A free **MaxMind account** with an Account ID and a License Key (you'll enter
  these during configuration).

## Install with Composer

From the project root:

```bash
composer require drupal/geoip_autoupdate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If GeoIP is not already present, add it too:
`composer require drupal/geoip -W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/geoip_autoupdate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geoip_autoupdate -y
```

Drupal enables the GeoIP module as a dependency at the same time.

## Verify it worked

After enabling, head to [Configuration](../configuration/index.md) to enter your
MaxMind credentials and fetch the database. Once GeoIP is pointed at the
`local_private` locator, the site status page (`/admin/reports/status`) will
report the private database and its age.
