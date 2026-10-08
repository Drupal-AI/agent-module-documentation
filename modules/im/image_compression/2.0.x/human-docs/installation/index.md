# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- PHP's **GD** extension (standard on virtually all Drupal hosting) — the module
  uses it to re-encode images.
- Your files directory (`sites/default/files`) must be **writable** by the web
  server, since the module rewrites files in place.

There are no third-party Composer or library requirements, and nothing is sent to an
external service.

> **Note:** this module is not currently covered by Drupal's security advisory
> policy. Weigh that as you would for any not-covered contrib module before using it
> on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/image_compression -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_compression -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_compression -y
```

Then clear the cache:

```bash
drush cr
```

## Check file permissions

Because compression rewrites files, the files folder needs proper write
permissions. The module's own docs suggest `766` on the files directory — apply your
host's recommended writable settings for `sites/default/files`.

## Verify it worked

Go to **Configuration → Image compression**
(`/admin/config/user-interface/image_compression`) and confirm the settings form
loads. Then follow [Configuration](../configuration/index.md) to add a size/rate
rule and try uploading an image — its stored file size should shrink.
