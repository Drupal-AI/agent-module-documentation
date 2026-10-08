# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Search** (`search`), **Language** (`language`), and **Content
  Translation** (`content_translation`) modules — Drupal enables them as
  dependencies.
- A **multilingual** site — the module only makes a difference when you have more
  than one language and translated content.

There are no third-party Composer or PHP library requirements, and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/search_current_language -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_current_language -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_current_language -y
```

That's all — there is no configuration and no permissions to set. As soon as it's
enabled, core node search returns only current-language (and language-neutral)
results, and the language filter is removed from the advanced search form.

> **Scope reminder:** this affects **core Search** only, not Search API.
