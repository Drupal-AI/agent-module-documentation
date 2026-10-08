# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Translation Management Tool** module (`drupal/tmgmt`, `^1.0`), which this
  module extends. Composer installs it and Drupal enables it as a dependency.
- A **DeepL API account** — either the free or the pro plan — providing an
  authentication key. This is external to Drupal but required for real
  translation.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tmgmt_deepl -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in TMGMT and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/tmgmt_deepl -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tmgmt_deepl -y
```

This also enables TMGMT if it is not already on. You will also want TMGMT's own
content sources (for example the content/node source) enabled so there is content
to translate.

## Submodule — Glossary

To manage DeepL glossaries (enforcing how specific terms are translated), enable
the submodule:

```bash
drush en tmgmt_deepl_glossary -y
```

Once enabled, add and configure a DeepL provider under **Translation → Providers**
— see [Configuration](../configuration/index.md).
