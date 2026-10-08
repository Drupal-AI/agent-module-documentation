# Installation

## Requirements

Soccer Bet needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.2 or newer**.
- Optionally, a free or paid **API key from football‑data.org** — required only
  for automatic match import and live score updates. Manual score entry works
  without it.

There are no other module dependencies and no third‑party Composer libraries.

> **A note on security coverage:** this project is **not** covered by Drupal's
> security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/soccerbet -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/soccerbet -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module and run updates

```bash
drush en soccerbet -y
drush updb -y
```

The `drush updb -y` step applies the module's database updates and is part of the
documented install process — don't skip it.

## Next step

Head to [Configuration](../configuration/index.md) to create a tournament, set the
scoring rules and permissions, add participants, and (optionally) connect the
football‑data.org API.
