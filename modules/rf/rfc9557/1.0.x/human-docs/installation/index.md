# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No modules outside Drupal core are required.
- To use the **Twig date-formatting filter**, the **Intl** PHP extension must be
  installed and enabled on your server. The rest of the module works without it.

Note this release (1.0.0-beta2) is not yet covered by Drupal's security advisory
policy.

## Install with Composer

From the project root:

```bash
composer require drupal/rfc9557 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rfc9557 -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rfc9557 -y
```

There is nothing to configure — the data type, validator, Twig filter, and helper
classes become available to other modules and to your code immediately.

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep rfc9557
```

If you plan to use the Twig filter, also confirm the Intl extension is present:

```bash
php -m | grep -i intl
```

From here, use the data type and validator from your own module — see the "How to
use it" section of the [overview](../index.md), and the module's test suite for
worked examples.
