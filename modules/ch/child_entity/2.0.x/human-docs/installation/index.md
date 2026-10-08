# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The contrib **Entity API** module (`entity`), which Composer pulls in as a
  dependency.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/child_entity -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the Entity API module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/child_entity -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en child_entity -y
```

Enabling the module makes its trait, handlers, and permissions available. On its
own it changes nothing on the site — the behavior appears only once your own
custom entity type uses it in code.

## Verify it worked

Confirm the module is enabled with `drush pml --status=enabled | grep child_entity`
(or check **Extend** in the admin UI). Since this is a developer toolkit, the real
test is that a custom child entity type using `ChildEntityTrait` builds its
parent-aware routes and access checks correctly.
