# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Language**, **Views**, **Block**, and **Options** modules — all part of
  Drupal core and enabled automatically as dependencies.
- Your site should already be multilingual: add the languages you want to translate
  into under **Configuration → Regional and language → Languages**, and enable
  content/configuration translation for the things you plan to translate.

There are no third-party Composer libraries in the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/tmgmt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tmgmt -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tmgmt -y
```

Enabling the base module gives you the framework, the **Translation** admin section,
and the review UI — but on its own it can neither read text nor translate it. You
need at least one **source** submodule and one **translator** submodule.

## Enable the submodules you need

TMGMT ships several submodules. Enable a **source** (what gets translated) and a
**translator** (how it gets translated) to match your workflow:

| Submodule | Machine name | Role | What it adds |
|-----------|--------------|------|--------------|
| **Content** | `tmgmt_content` | Source | Translate nodes and other content entities. |
| **Configuration** | `tmgmt_config` | Source | Translate config entities (views, fields, menus). |
| **Locale** | `tmgmt_locale` | Source | Translate interface/locale strings. |
| **File** | `tmgmt_file` | Translator | Export to XLIFF/HTML and import the translation back — hand off to an external agency. |
| **Local** | `tmgmt_local` | Translator | Route work to human translators inside Drupal. |
| **Language Combination** | `tmgmt_language_combination` | Support | A "language abilities" field used by local translation. |

For a typical "translate content with in-house translators" setup:

```bash
drush en tmgmt_content tmgmt_local -y
```

Enabling a translator submodule usually creates a default provider for you, ready to
configure. Add or remove submodules at any time as your needs change.

## Next steps

With the base module and your chosen submodules enabled, head to
[Configuration](../configuration/index.md) to set up a provider and request your
first translation.
