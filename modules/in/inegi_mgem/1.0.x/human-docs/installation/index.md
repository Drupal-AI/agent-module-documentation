# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Block** module (`block`) enabled — this is the only dependency, and it
  is part of Drupal core, so it is available on any standard site.
- Outbound HTTPS access from your server to INEGI's public endpoints at
  `gaia.inegi.org.mx` (the module fetches data live). No API key or account is
  required.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/inegi_mgem -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inegi_mgem -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inegi_mgem -y
```

## Verify it worked

Log in as an administrator and go to **Structure → Block layout**
(`/admin/structure/block`). Click **Place block** and confirm that the **State
lookup** and **Municipal/Locality lookup** blocks appear in the list. Place one,
enter a valid Mexican state code, and view the page to confirm data is returned
from INEGI. See the overview page's "How to use it" for the full placement walk-
through.
