# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- To be useful, a **multilingual** setup: core's **Language** and **Content
  Translation** modules enabled, with at least two languages and a translatable
  content type. The module itself declares no hard module dependencies.

There are no third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_edit_language_switcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_edit_language_switcher -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_edit_language_switcher -y
```

## Verify it worked

Edit a translatable node on a multilingual site — a language switcher should appear on
the edit form, letting you move between translations. If it doesn't show, confirm the
content type is enabled for translation and that more than one language is configured.
