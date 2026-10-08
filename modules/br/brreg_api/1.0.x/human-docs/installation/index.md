# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies and no third‑party PHP libraries.
- **No credentials** — the Brreg (Enhetsregisteret) API is public, so there is
  nothing to store. The site does need outbound HTTPS access to
  `https://data.brreg.no`.

## Install with Composer

From the project root:

```bash
composer require drupal/brreg_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/brreg_api -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en brreg_api -y
```

There is nothing to configure after enabling — call the `brreg_api.client` service
from your own code as shown in [the overview](../index.md).
