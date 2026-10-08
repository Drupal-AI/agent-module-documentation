# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- A **PayU merchant account** with your PayU credentials (point-of-sale ID, second
  / MD5 signature key, and the OpenPayU signature key).

There are no additional Composer library requirements beyond the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/payu_donations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/payu_donations -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en payu_donations -y
```

## Verify it worked

Log in as an administrator, go to **Structure → Block layout**
(`/admin/structure/block`), and confirm the PayU donation block is available to
place. Then enter your PayU credentials (see
[Configuration](../configuration/index.md)) and run a test donation against PayU's
sandbox before going live.
