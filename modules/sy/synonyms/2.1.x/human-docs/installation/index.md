# Installation

## Requirements

Synonyms is core-only. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no contributed-module dependencies and no third-party PHP libraries. Which
core modules matter depends on the submodules you enable (for example the search
submodule builds on core Search, and the Views submodules on core Views).

## Install with Composer

From the project root:

```bash
composer require drupal/synonyms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/synonyms -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en synonyms -y
```

The base module is a framework and has **no user-facing effect on its own** — you
also need at least one submodule for the integration you want, and you need to
register a provider (see [Configuration](../configuration/index.md)).

## Submodules — enable the integrations you need

The base module provides the framework; each submodule is a distinct integration
("behavior"). Enable the ones you need with `drush en`:

| Submodule | What it adds |
|-----------|--------------|
| `synonyms_autocomplete` | Autocomplete on entity-reference fields that matches by synonym, not just the primary label |
| `synonyms_select` | A select widget whose options include each entity's synonyms |
| `synonyms_search` | Lets core Search find a node by a synonym of an entity it references |
| `synonyms_list_field` | A computed "Synonyms list" field to show on an entity's display |
| `synonyms_views_field` | Exposes the synonyms list as a Views field |
| `synonyms_views_filter` | A Views exposed filter matching entities by name **or** synonym |
| `synonyms_views_argument_validator` | Validates a Views contextual-filter argument against a name or synonym |

For example, to add synonym-aware autocomplete and search:

```bash
drush en synonyms_autocomplete synonyms_search -y
```

## Production note

The Synonyms UI/config forms are mainly a dev-time convenience. Once your Synonym
provider configs and behaviors are set and exported, you can uninstall those config
forms on production and synonyms keep working through the exported configuration.

Continue to [Configuration](../configuration/index.md) to register providers and
enable behaviors.
