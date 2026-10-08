# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no third-party Composer or library requirements. This module is minimally
maintained (maintenance fixes only), but it is covered by Drupal's security advisory
policy.

## Install with Composer

From the project root:

```bash
composer require drupal/image_domain_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_domain_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_domain_filter -y
```

Then clear the cache:

```bash
drush cr
```

Enabling the module makes the filter *available*, but it does nothing until you turn
it on for a specific text format — see [Configuration](../configuration/index.md).

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) and edit any format. In the **Enabled filters**
list you should now see **Restrict images to trusted sites**. Once you enable and
configure it (next page), embedding an image from a non-allowlisted host in that
format should no longer be permitted.
