# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **User** module (`user`) — this is the only dependency, and it is enabled
  on every standard Drupal site.

There are no third‑party Composer or PHP‑library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/questions_answers -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/questions_answers -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en questions_answers -y
```

## Verify it worked

Log in as an administrator and open **Configuration → Content authoring →
Questions and Answers** (`/admin/config/content/questions-answers`) — the global
settings form should load. The Q&A thread itself only appears once you add the
**Questions and Answers** field to a bundle and grant the relevant permissions; see
[Configuration](../configuration/index.md) for those steps.
