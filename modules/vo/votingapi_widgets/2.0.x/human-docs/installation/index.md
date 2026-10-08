# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Voting API** module (`drupal/votingapi` `^4.0`) — Composer pulls it in for
  you. Its `votingapi` module is enabled automatically as a dependency.
- Core's **Field** module (`field`), which is part of a standard install.
- For the **five-star** widget only: the [jQuery Bar Rating](https://github.com/antennaio/jquery-bar-rating)
  JavaScript library, placed at `/libraries/jquery-bar-rating` (see below). The
  **like** and **useful** widgets do not need it.

## Install with Composer

From the project root:

```bash
composer require drupal/votingapi_widgets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Voting API and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/votingapi_widgets -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en votingapi_widgets -y
```

This enables Voting API at the same time.

## Add the five-star JavaScript library (optional)

If you plan to use the five-star widget, download the jQuery Bar Rating library and
place it so the file `/libraries/jquery-bar-rating/dist/jquery.barrating.min.js`
exists under your web root. The module runs a status check (`hook_requirements`)
that warns you on the **Status report** if the library is missing. The like and
useful widgets have no library requirement.

## Next steps

The module ships no example fields — nothing is rated until you add a Voting API
field. Continue to [Configuration](../configuration/index.md) to create your first
rating field and grant the voting permissions.
