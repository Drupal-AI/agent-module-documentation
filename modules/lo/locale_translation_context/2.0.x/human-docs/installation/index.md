# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Interface Translation** module (`locale`) — enabled automatically as a
  dependency. You will also need at least one non‑English language configured for
  the translation screens to be useful.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/locale_translation_context -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/locale_translation_context -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en locale_translation_context -y
```

## Verify it worked

Go to **Configuration → Regional and language → User interface translation →
Translate**. You should see a new **context** filter alongside the usual filters.
On the **Export** screen you should likewise see an option to export strings for a
specific context.
