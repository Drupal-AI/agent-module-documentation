# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- Core's **System** (`system`) module, which is always present in a Drupal install.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_autocomplete_suggestions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_autocomplete_suggestions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_autocomplete_suggestions -y
```

## Verify it worked

The module starts enriching suggestions as soon as it is enabled, using its defaults
(entity type shown, unpublished content hidden, limit of 10). Type into any
entity-reference autocomplete field and you should see the entity type appended to
each suggestion label. To adjust what appears, go to **Configuration → Entity
Autocomplete Suggestions Config**
(`/admin/config/autocomplete-suggestion-configurations`) — see
[Configuration](../configuration/index.md).
