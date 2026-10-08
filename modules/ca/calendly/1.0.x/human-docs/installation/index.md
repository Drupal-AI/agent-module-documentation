# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No module dependencies and no third-party Composer or PHP libraries — the
  module loads Calendly's JavaScript from Calendly at runtime.
- A **Calendly account** with at least one scheduling page (you supply its URL).

## Install with Composer

From the project root:

```bash
composer require drupal/calendly -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/calendly -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en calendly -y
```

## Set it up

Copy your Calendly scheduling URL from your Calendly account, then add the
Calendly embed where you want booking to appear and paste the URL in. Choose the
inline or popup style. (A Calendly API token is only needed if you go beyond the
basic embed into Calendly's API — the standard embed just needs the URL.)
