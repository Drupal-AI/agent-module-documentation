# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Taxonomy**, **Node**, and **Field** modules (`taxonomy`, `node`,
  `field`) — all part of standard Drupal and enabled automatically as
  dependencies.

There are no third-party Composer or PHP library requirements.

**Optional integrations** (nothing to configure — support activates automatically
if the module is present):

- [Commerce](https://www.drupal.org/project/commerce) — adds Commerce Product as a
  protectable referencing entity type.
- [Paragraphs](https://www.drupal.org/project/paragraphs) — treats paragraph
  references as protection triggers, resolved to their parent node/entity.
- [Markdown](https://www.drupal.org/project/markdown) — renders the module's README
  as formatted markdown on its help page.

## Install with Composer

From the project root:

```bash
composer require drupal/term_delete_protection -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/term_delete_protection -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en term_delete_protection -y
```

Enabling the module does not protect anything yet — nothing is guarded until you
turn protection on for a vocabulary. Head to
[Configuration](../configuration/index.md) to do that.

This module has no submodules.
