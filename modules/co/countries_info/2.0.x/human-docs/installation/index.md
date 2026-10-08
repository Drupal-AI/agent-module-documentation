# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Taxonomy**, **Options**, **Text**, and **Path** modules — these are hard dependencies
  and Drupal enables them automatically. (Path is needed for the `/country-info/<ISO2>` term
  aliases.)

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/countries_info -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/countries_info -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en countries_info -y
```

**On enable, the module does the work for you:** it creates the `cit_countries_information`
vocabulary and its five fields, then seeds ~249 country terms from the bundled
`data/countries.csv`. (If the vocabulary already exists, it is left as-is.) You do not need to
configure anything — the terms are immediately available to reference, list, and facet (see
[How to use it](../index.md#how-to-use-it)).

## Uninstalling

Uninstalling the module **deletes the `cit_countries_information` vocabulary and all of its
terms.** If you have referenced those terms from content, those references will be affected — so
uninstall deliberately.

There are no submodules.
