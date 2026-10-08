# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No other modules are required, and there are no third-party Composer or PHP
  library requirements. Signatures are typically used alongside core's Comment
  and node content, but the module declares no hard dependency on them.

Note that this project is **not covered by Drupal's security advisory policy**, so
weigh that against your site's needs.

## Install with Composer

From the project root:

```bash
composer require drupal/signature -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/signature -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en signature -y
```

After enabling, a **Signature** field appears on the user profile edit form.
Before you rely on it, make sure signatures are rendered through a **restricted
text format** so a user cannot inject scripts through their signature — see the
main guide's [How to use it](../index.md#how-to-use-it) section.
