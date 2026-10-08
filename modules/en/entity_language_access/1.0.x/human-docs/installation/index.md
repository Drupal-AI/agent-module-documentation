# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Language** module (`language`) — the only dependency, and Drupal enables
  it automatically. For the module to have any effect, your site needs to be
  multilingual with translatable content entity types.

There are no third‑party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_language_access -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_language_access -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_language_access -y
```

The language‑based access check becomes active immediately for all translatable
content entity types that have a canonical route in all languages. There is no
required configuration — the optional fallback page and the bypass/administer
permissions are covered in the [overview](../index.md).

## Verify it worked

On a multilingual site, view a node that exists in one language while browsing in a
language it has *not* been translated into. You should get a forbidden (403) response
(or your configured fallback content) rather than the original‑language content.

> **Don't forget listings.** This module only affects the canonical view. Add a
> translation‑language filter to your Views and other content listings, or
> untranslated entities will still appear there.
