# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Contributed modules **Domain** (`domain`), **Domain Source**
  (`domain_source`), and **Pathauto** (`pathauto`).
- Core modules **Path alias** (`path_alias`), **Field** (`field`), and **Node**
  (`node`).

Drupal will pull the core dependencies in automatically; make sure Domain, Domain
Source, and Pathauto are installed via Composer (below) before enabling.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/domain_unique_path_alias -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This release is distributed as a beta; if Composer does
not resolve it under your stability settings, request the beta explicitly:

```bash
composer require 'drupal/domain_unique_path_alias:^1.0@beta' -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/domain_unique_path_alias -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en domain_unique_path_alias -y
```

Drupal will prompt to enable Domain, Domain Source, Pathauto, and the required
core modules as dependencies if they are not already on.

## Verify it worked

On a multi‑domain site, create (or let Pathauto generate) the same alias — for
example `/contact` — pointing at different content on two different domains. Both
should save successfully and each domain should resolve its own. Then try to
create a *duplicate* alias within a single domain: that should still be rejected,
confirming per‑domain uniqueness is in force.
