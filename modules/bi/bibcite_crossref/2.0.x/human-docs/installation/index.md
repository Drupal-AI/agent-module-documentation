# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **Bibcite** and **Bibcite Entity** modules (`bibcite`,
  `bibcite_entity`) — Composer pulls in the Bibcite project for you if it is not
  already present.
- Outbound HTTPS network access from the server, so it can reach the Crossref
  API. No API key or credentials are required.

This is a **beta** release (2.0.0-beta1); test it before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/bibcite_crossref -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Bibcite
dependencies and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bibcite_crossref -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bibcite_crossref -y
```

Drupal enables Bibcite and Bibcite Entity automatically as dependencies. There
is no configuration page — the DOI lookup is available inline when you create a
reference (see the [main guide](../index.md)).
