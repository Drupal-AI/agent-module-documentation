# Installation

## Requirements

- **Drupal 9.3+, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Locale** (`locale`) module — for the interface-translation string
  tables and the `.po` machinery.
- Core's **Configuration Translation** (`config_translation`) module — this is the
  page the Export/Import tabs attach to.
- A multilingual site with at least one non-default language configured.

There are no third-party PHP library requirements, no permissions of its own, and
no Drush commands.

## Install with Composer

From the project root:

```bash
composer require drupal/config_translation_po -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_translation_po -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_translation_po -y
```

This enables `locale` and `config_translation` if they are not already on.

## Verify it worked

Go to **Configuration → Regional and language → Configuration translation**
(`/admin/config/regional/config-translation`). You should now see **Export** and
**Import** tabs on that page. See [Configuration](../configuration/index.md) for
how to use them.
