# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`). This module uses
  attribute-based listener registration that only recent core supports, so it
  will not install on older versions.

There are no other module dependencies and no third-party Composer or PHP
libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/ael -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ael -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ael -y
```

That is all the setup there is. From here it is used in code — see
[How to use it](../index.md#how-to-use-it) on the overview page.
