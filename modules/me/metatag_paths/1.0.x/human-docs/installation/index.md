# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4||^11`).
- The **Metatag** module (`metatag`) — required.
- Core's **Path Alias** module (`path_alias`) — required; core provides it.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/metatag_paths -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Metatag if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/metatag_paths -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en metatag_paths -y
```

## Verify it worked

Go to **Configuration → Search and metadata → Metatag** and confirm an **Add
metatag for path pattern** action is available. Create a pattern (for example
`/news/`), set a meta tag on it, then visit a matching page and check that the tag
appears in the page source. See the module's [overview](../index.md) for the full
pattern syntax.
