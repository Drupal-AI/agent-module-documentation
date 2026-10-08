# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11.0 || ^12`).
- The **igbinary PECL extension** compiled into your PHP runtime — this is the key
  requirement. Without it, the module's services do nothing. Confirm it is present
  before relying on the module.
- The **zlib** PHP extension, required for the gzip‑compressed serialization
  variants.

There are no additional Composer library requirements and no module dependencies
beyond core, but the PHP extension above is an **infrastructure** prerequisite you
provide at the server/container level, not through Composer.

## Confirm the PHP extension

Check that the igbinary extension is loaded:

```bash
php -m | grep -i igbinary
```

If it prints `igbinary`, the extension is available. If nothing prints, install
it for your PHP runtime first (for example via PECL or your platform's PHP
extension package). On DDEV you would add the extension to your web‑image
configuration and restart before continuing.

## Install with Composer

From the project root:

```bash
composer require drupal/igbinary -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/igbinary -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en igbinary -y
```

Enabling the module makes its serialization services available; it does not
change anything on its own until you point a backend at those services (see the
[main guide](../index.md#how-to-use-it)).

## Verify it worked

With the extension present and the module enabled, the services
`serialization.igbinary` and `serialization.igbinary_gz` are available in the
container. After you wire a cache or queue backend to one of them in
`settings.php` and flush caches, the site should serialize that data in
igbinary's compact binary form.
