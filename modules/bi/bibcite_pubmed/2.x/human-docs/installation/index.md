# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Bibcite** and **Bibcite Entity** modules (`bibcite`,
  `bibcite_entity`) — Composer pulls in the Bibcite project for you if it is not
  already present.
- Outbound HTTPS network access so the site can reach PubMed's public API. No
  API key or credentials are required for standard reads.

This is a **beta** release (2.0.0-beta1); test it before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/bibcite_pubmed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Bibcite
dependencies and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bibcite_pubmed -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bibcite_pubmed -y
```

Drupal enables Bibcite and Bibcite Entity automatically as dependencies. There
is no configuration page — use the PubMed lookup/import while managing Bibcite
references (see the [main guide](../index.md)).
