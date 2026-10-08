# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No dependent contrib modules, no PHP requirement, and no third-party Composer
  libraries. Intended for sites using Single Directory Components.
- The optional **SDC Library Paragraphs** submodule integrates with the Paragraphs
  module, so you would need Paragraphs installed to use that submodule.

This is an early release (`1.0.0-alpha4`) that the maintainers describe as **not yet
ready for production** — test it on a non-production copy.

## Install with Composer

From the project root:

```bash
composer require drupal/sdc_library -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sdc_library -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sdc_library -y
```

## Submodule — optional Paragraphs integration

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **SDC Library Paragraphs** | `sdc_library_paragraphs` | Integration between the SDC library and the Paragraphs module. Enable it only if you use Paragraphs. |

```bash
drush en sdc_library_paragraphs -y
```

## After enabling

Grant the module's permission to the roles that should be able to browse the
component library (under **People → Permissions**), then open the component browser
to explore the available Single Directory Components.
