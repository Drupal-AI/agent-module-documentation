# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- A **LinkedIn Partner ID** — you get this from your LinkedIn Campaign Manager account when you
  set up the Insight Tag. Without it the module loads nothing.

There are no other contrib module dependencies and no third-party PHP libraries. (The tracking
script itself is loaded at runtime from LinkedIn's `snap.licdn.com` CDN.)

## Install with Composer

From the project root:

```bash
composer require drupal/linkedin_insights_tag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/linkedin_insights_tag -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en linkedin_insights_tag -y
```

Enabling the module does not start any tracking — nothing is emitted until you enter a Partner
ID. Head to [Configuration](../configuration/index.md) to add it and choose which roles are
tracked.
