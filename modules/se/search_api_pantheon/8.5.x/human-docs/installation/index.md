# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- **Search API Solr** (`drupal/search_api_solr` `^4.3`), which Composer pulls in
  automatically. It in turn brings **Search API** — both are enabled automatically
  when you enable this module.
- A **Pantheon** hosting environment. This module only works on Pantheon's platform;
  off Pantheon it does nothing.

## Pantheon prerequisites (do these first)

1. **Enable Solr as an add-on** in your Pantheon site dashboard (under Settings).
2. **Set the Solr version in `pantheon.yml`** at the root of your repository:

   ```yaml
   search:
     version: 9   # or 8
   ```

   This file follows your code across environments, and each environment
   (Dev/Test/Live/Multidev) gets its own isolated Solr core.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_pantheon -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in `search_api_solr` and `search_api`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_pantheon -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix. Note that the module
> is only functional on Pantheon itself.

## Enable the module

```bash
drush en search_api_pantheon -y
```

Enabling it also enables Search API and Search API Solr, and installs the **Pantheon
Search** server plus a **Primary** index — both visible at **Configuration → Search
and metadata → Search API**. Do not hand-edit the server's host or core: the module
force-sets those from Pantheon's environment variables at runtime.

> Only **one** Pantheon-connector server per environment is supported. Additional
> Pantheon servers all point at the same Solr core and cause schema conflicts.

## Submodules

| Submodule | Machine name | Note |
|-----------|--------------|------|
| Search API Pantheon Admin | `search_api_pantheon_admin` | **Obsolete as of 8.4.x** — do not enable on new sites. |
| Search API Pantheon Examples | `search_api_pantheon_examples` | An example/demo module, not for production. |

## Next steps

There is no settings form to fill in. Head back to the [overview](../index.md) for
the setup flow: add fields to the Primary index, run
`drush search-api-pantheon:postSchema`, and index your content.
