# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`). There
  is no Drupal 11 release of this module.
- The **Brandfolder** module (`brandfolder`), which this module depends on and
  whose API key it reuses to talk to Brandfolder. Set that module up first.
- A Brandfolder account and API key (configured in the Brandfolder module).
- Outbound HTTPS access from the server to Brandfolder's API and CDN, so assets
  can be listed and downloaded.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/brandfolderassets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies (including the Brandfolder module) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/brandfolderassets -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en brandfolderassets -y
```

This also enables the Brandfolder module if it is not already on. Configure the
Brandfolder API key in that module before using the picker.

## Next step

See [Configuration](../configuration/index.md) to set the module's display
options and add the field to a content type.
