# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- The **Tamper** module (`tamper:tamper`) enabled.
- The **Feeds Tamper** module (`feeds_tamper:feeds_tamper`) enabled (and the
  **Feeds** module it builds on).
- The **league/commonmark** PHP library, which Composer installs automatically as a
  dependency of this module.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_tamper_markdown -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. This pulls in the league/commonmark library, and Tamper /
Feeds Tamper if they aren't present yet.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_tamper_markdown -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_tamper_markdown -y
```

This also enables Tamper and Feeds Tamper if they aren't on yet.

## Verify it worked

Open a Feed type's **Tamper** tab at **Structure → Feed types**
(`/admin/structure/feeds`). When you add a plugin to a field, you should find
**Convert Markdown to HTML** under the **Text** group.
