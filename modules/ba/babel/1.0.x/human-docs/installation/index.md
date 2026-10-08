# Installation

## Requirements

- **Drupal 10.4+, 11.1+ or 12** (`core_version_requirement: ^10.4 || ^11.1 || ^12`).
- Core's **Locale** module (`locale`) — Drupal's interface‑translation system, which
  Babel builds on. Drupal enables it automatically as a dependency. You also need at
  least one additional language configured for translation to be meaningful.

There are no third‑party Composer or PHP library requirements declared.

## Install with Composer

From the project root:

```bash
composer require drupal/babel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/babel -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

> **Note:** this is an alpha release. Test it on a non‑production environment before
> relying on it.

## Enable the module

```bash
drush en babel -y
```

This enables Locale too if it wasn't already on. Grant Babel's translation‑management
permission to the users who will do translation work.
