# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- Core's **File** module (`file`), which this module depends on and Drupal will
  enable automatically.
- A way to run **Drush**, since URLs are minted with the `presigned-url:sign`
  command.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/presigned_url -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/presigned_url -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en presigned_url -y
```

## Verify it worked

Once enabled, confirm the signing command is available:

```bash
drush list | grep presigned
```

You should see `presigned-url:sign`. Before generating real links, set up the
private signing key and expiry as described in
[Configuration](../configuration/index.md).
