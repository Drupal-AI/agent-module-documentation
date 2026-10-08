# Installation

## Requirements

Target Attributes Filter is lightweight. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Filter** module (`filter`), which provides the text-format filter
  system — this is the only dependency and is part of core.

There are no third-party Composer or PHP library requirements. The module is
covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/target_attributes_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (The Composer package name,
`drupal/target_attributes_filter`, matches the module's machine name,
`target_attributes_filter`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/target_attributes_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en target_attributes_filter -y
```

Enabling the module makes the *Add target attribute to links* filter available on
your text formats, but it does nothing until you switch it on for a specific
format — see [Configuration](../configuration/index.md).

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), edit any format, and confirm that *Add target
attribute to links* appears in the list of available filters.
