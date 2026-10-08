# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Media** module (`media`), enabled automatically as a dependency.

There are no third-party Composer or PHP library requirements.

**Compatibility caveat:** this module swaps out core Media's oEmbed provider
repository service for its own extended version. If another contrib module also
modifies that service, the two will conflict — only one such module can win.

## Install with Composer

From the project root:

```bash
composer require drupal/oembed_providers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/oembed_providers -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oembed_providers -y
```

The module ships **no submodules**.

## Verify it worked

Log in as an administrator and go to **Configuration → Media → oEmbed Providers**
(`/admin/config/media/oembed-providers`). You should see the settings form along
with **Custom providers** and **Buckets** tabs. See
[Configuration](../configuration/index.md) to add your first provider or bucket.
