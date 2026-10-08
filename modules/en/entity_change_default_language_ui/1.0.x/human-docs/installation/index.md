# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- The **`entity_change_default_language`** API module — this UI is built on top of
  it, and it must be enabled. Composer will pull it in as a dependency.
- A multilingual site (core Language and Content Translation configured) for the
  feature to be meaningful.

> **Note:** This project is not covered by Drupal's security advisory policy, and its
> forms perform destructive changes (switching a node's original language deletes its
> non-preserved translations). Limit access to trusted administrative roles before use.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_change_default_language_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including the `entity_change_default_language` API module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_change_default_language_ui -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_change_default_language_ui -y
```

Drush will enable the `entity_change_default_language` API module at the same time
if it is not already on.

## Verify it worked

Go to the **Content** list — each node's **Operations** menu should now include
**Change default language**. You should also find the batch form at **Configuration
→ Region and language → Change entities default language**
(`/admin/config/regional/change-default-language`).
