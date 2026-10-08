# Installation

## Requirements

- **Drupal 10.6 or 11** (`core_version_requirement: ^10.6 || ^11.0`).
- No modules outside Drupal core are required for the base module, and there are no
  third‑party PHP library requirements.
- The optional **Config Terms Views** submodule (`config_terms_views`) is needed if
  you want to list config terms in a View.

This is the 2.0.x branch and the project is minimally maintained.

## Install with Composer

From the project root:

```bash
composer require drupal/config_terms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_terms -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_terms -y
```

## Submodules

- **Config Terms Views** (`config_terms_views`) — integrates config terms with
  Views so you can build listings of them. Enable it only if you need Views
  listings:

  ```bash
  drush en config_terms_views -y
  ```

## Verify it worked

Go to **Structure → Config terms** (`/admin/structure/config-terms`), create a test
vocabulary, and add a term. Then run `drush cex` and confirm the vocabulary and term
appear as `config_terms_vocab.*` and `config_terms_term.*` YAML files in your config
sync folder — that is the whole point of the module, and it confirms the terms are
being stored as configuration.
