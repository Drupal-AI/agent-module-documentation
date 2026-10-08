# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).

That's it — Resource Hints has no module dependencies and no third-party Composer or
PHP library requirements. It adds one permission of its own, **Administer resource
hints**.

## Install with Composer

From the project root:

```bash
composer require drupal/resource_hints -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/resource_hints -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en resource_hints -y
```

## Right after enabling

Grant the **Administer resource hints** permission to the roles that should manage
hints (at *People → Permissions*), then open *Configuration → Development →
Performance → Resource Hints* to enter the domains and URLs you want the browser to
prefetch or preconnect to. The full walkthrough is in the
[overview](../index.md#how-to-use-it). Until you configure some resources, the module
emits nothing.

This module has no submodules.
