# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- Core's **Serialization** and **Views** modules — both ship with Drupal core.
  Drupal enables them as dependencies when you turn on Lunr.

There are no third‑party Composer or PHP library requirements. (For command‑line
indexing, Lunr includes an optional Node.js script — see the module's README.)

## Install with Composer

From the project root:

```bash
composer require drupal/lunr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/lunr -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lunr -y
```

## Submodules

Lunr ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Lunr Facet Example** | `lunr_facet_example` | A worked example of adding faceted/field search to a Lunr page. Enable it if you want a reference implementation to learn from; it is not required for basic search. |

Enable it the same way when you need it:

```bash
drush en lunr_facet_example -y
```

## Verify it worked

If the **Node** module was enabled before Lunr, a default Lunr search entity is
created automatically. In that case you can confirm the install by visiting
`/admin/config/lunr_search/default/index`, clicking **Index**, and then loading
the search page at `/search`. If no default entity exists, create one as
described in [Configuration](../configuration/index.md).
