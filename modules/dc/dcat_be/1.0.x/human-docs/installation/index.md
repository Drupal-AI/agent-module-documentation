# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- DCAT-BE sits on top of the whole DCAT stack and several contrib modules. Composer
  and Drush resolve these for you, but for reference the dependencies are:
  - **DCAT stack:** [DCAT](https://www.drupal.org/project/dcat) (`dcat`), its
    **DCAT Export** submodule (`dcat_export`), and
    [DCAT-AP](https://www.drupal.org/project/dcat_ap) (`dcat_ap`).
  - **Core:** Taxonomy, Language, Views, Content Translation.
  - **Contrib:** [Inline Entity Form](https://www.drupal.org/project/inline_entity_form),
    [Entity Browser](https://www.drupal.org/project/entity_browser) (plus its Entity
    Form submodule), [Address](https://www.drupal.org/project/address), and
    [Field Group](https://www.drupal.org/project/field_group).
- Outbound HTTPS access to the official vocabulary sources
  (`publications.europa.eu`, `inspire.ec.europa.eu`, Belgif) is used during
  vocabulary import — the module ships fallback data if a source is unreachable.

## Install with Composer

From the project root:

```bash
composer require drupal/dcat_be -W
```

The `-W` (`--with-all-dependencies`) flag matters here — DCAT-BE has many
dependencies, and this lets Composer install the whole DCAT stack and the required
contrib modules together.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dcat_be -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dcat_be -y
```

Enabling DCAT-BE also enables the DCAT stack (DCAT, DCAT Export, DCAT-AP) and the
contrib dependencies above. It creates the License, Location, and Quality
Measurement entity types.

## Verify it worked

Log in as an administrator with the *Administer DCAT BE* permission and visit the
DCAT-BE settings at `/admin/structure/dcat/settings/dcat-be`, and the vocabulary
import page at `/admin/structure/dcat/vocabulary-import`. Both should load. Then
continue to [Configuration](../configuration/index.md) to import the vocabularies
and set up validation and export.
