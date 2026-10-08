# Installation

## Requirements

Attach Inline needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no module dependencies and no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/attachinline -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/attachinline -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en attachinline -y
```

There is no configuration form. Once enabled, attach inline JS/CSS to a render array
from your own module or theme — see the [overview guide](../index.md#how-to-use-it),
and mind the security note there about never building snippets from request or
content data.
