# Installation

> **Before you install:** the maintainers recommend **TranslationBliss** as the
> successor to MultiLangNG. Consider that project for new sites; install
> MultiLangNG only if you already rely on it.

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's multilingual stack (Language and Configuration Translation) as you would
  use for any multilingual site.

There are no third‑party Composer or PHP library requirements declared.

## Install with Composer

From the project root:

```bash
composer require drupal/multilangng -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/multilangng -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

The runtime config‑translation feature lives in the **MultiLangNG Translations**
submodule:

```bash
drush en multilangng_translations -y
```

(Enabling the submodule brings in the base MultiLangNG module.)

## Verify it worked

With the submodule enabled, configuration is translated at runtime through
MultiLangNG's alternative service. Review the module's README for exactly which
config‑translation behaviors it changes, and check your translated configuration
renders as expected in each language. If you provide translations for non‑English
configuration, confirm they now appear where core previously fell back to the
original strings.
