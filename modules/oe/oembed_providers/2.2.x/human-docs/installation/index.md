# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module (`media`) — enabled automatically as a dependency, since
  this module extends Media's oEmbed support.

There are no third-party Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/oembed_providers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oembed_providers -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oembed_providers -y
```

## Next steps

After enabling, grant the **Administer oembed providers** permission to the roles
that should manage providers, then head to **Configuration → Media → oEmbed
Providers** to add custom providers and buckets — see
[Configuration](../configuration/index.md).

There are no submodules.
