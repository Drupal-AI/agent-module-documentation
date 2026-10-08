# Installation

## Requirements

- **Drupal 8.7.7, 9, 10, or 11** (`core_version_requirement: ^8.7.7 || ^9 || ^10 || ^11`).
- Core's **Content Translation** module (`content_translation`) enabled — this is
  the only dependency, and Drupal will enable it automatically when you turn on
  Content Language Switcher.
- A **multilingual site**: you should have more than one language added (under
  **Configuration → Regional and language → Languages**) and content translation
  configured for the entity types you want to translate. The switcher has nothing
  to show until translations are possible.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_language_switcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_language_switcher -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_language_switcher -y
```

## Verify it worked

Open the edit form of a translatable content item on your multilingual site. You
should see the inline language switcher in the form sidebar listing the available
translation languages, and the separate **Translate** tab should no longer appear
on that content. If you don't see it, confirm that the entity type is enabled for
translation and that your site has more than one language.
