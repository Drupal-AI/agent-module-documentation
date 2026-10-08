# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- A **multilingual** site that negotiates content language from the **URL** (prefix or
  domain) — that's the situation the module corrects. It declares no hard module
  dependencies, but only has an effect in that URL‑based language setup.

There are no third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_edit_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_edit_redirect -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_edit_redirect -y
```

## Verify it worked

On a URL‑language site with translated content, open the edit form for a translation
under a mismatched language prefix (for example an English node under `/fr/`). The
form should redirect so the prefix matches the translation's language (e.g.
`/fr/node/3` → `/en/node/3`). There is nothing to configure.
