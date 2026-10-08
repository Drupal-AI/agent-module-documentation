# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Token** module (`drupal/token`) — a hard dependency, since the appended
  suffix is built from tokens.

There are no other third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_autocomplete_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including pulling in the required Token module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_autocomplete_plus -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

This enables Entity Autocomplete Plus along with the Token dependency:

```bash
drush en entity_autocomplete_plus -y
```

## Verify it worked

Go to **Configuration → Content authoring → Entity Autocomplete Plus**
(`/admin/config/content/entity_autocomplete_plus`). If the settings form loads, the
module is installed. To see the effect, set a token string (globally or on a
specific field, see [Configuration](../configuration/index.md)) and then start
typing into a matching entity-reference autocomplete field — each suggestion should
now show your appended context after its label.
