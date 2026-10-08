# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **Key** module (`key`) — this is a hard dependency. Ecomail uses it to store
  your Ecomail API key securely. Composer pulls it in automatically, and Drupal
  enables it as a dependency.
- An **Ecomail account** and an **Ecomail API key** from your Ecomail dashboard.

There are no additional PHP library requirements. Note that this release is a
beta and its security advisory coverage is *not* covered by the Drupal Security
Team — weigh that for production use.

## Install with Composer

From the project root:

```bash
composer require drupal/ecomail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies (including Key) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ecomail -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ecomail -y
```

This also enables the Key module if it wasn't already on.

## Verify it worked

Confirm both modules are enabled:

```bash
drush pm:list --status=enabled | grep -E 'ecomail|key'
```

You should see `ecomail` and `key` listed. The integration is installed but not
yet usable — you still need to supply your Ecomail API key. Continue to
[Configuration](../configuration/index.md).
