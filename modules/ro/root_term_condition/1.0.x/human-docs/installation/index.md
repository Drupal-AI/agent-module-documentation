# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) — this is the only dependency, and
  Drupal enables it automatically when you turn on Root term condition.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/root_term_condition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/root_term_condition -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en root_term_condition -y
```

## Verify it worked

Go to **Structure → Block layout** and place or edit a block. Open its
**Visibility** settings — you should now see the new condition for parentless
(root) taxonomy terms available alongside the core conditions. If it appears
there, the module is installed correctly.
