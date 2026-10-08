# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core **Taxonomy** module (`taxonomy`) — enabled automatically as a dependency.
- No modules outside Drupal core are required.

There are no extra PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_internal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_internal -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_internal -y
```

There is no dedicated settings form — you mark individual vocabularies as
internal on their edit forms (see the [main guide](../index.md)).

## Verify it worked

Go to **Structure → Taxonomy** (`/admin/structure/taxonomy`) and edit any
vocabulary. You should see a new option to mark the vocabulary as **internal**.
Turn it on for a test vocabulary, then view one of its term pages as an anonymous
or non‑editor user: the canonical term page should no longer be accessible to
them, and for an editor it should render in the admin theme.
