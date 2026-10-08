# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Tamper** module (`tamper:tamper`) enabled.
- The **Feeds Tamper** module (`feeds_tamper:feeds_tamper`) enabled (and the
  **Feeds** module it builds on).

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_tamper_mislabeled_encoding -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer will bring in Tamper and Feeds Tamper if they
aren't present yet.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_tamper_mislabeled_encoding -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_tamper_mislabeled_encoding -y
```

This also enables Tamper and Feeds Tamper if they aren't on yet.

## Verify it worked

Open a Feed type's **Tamper** tab at **Structure → Feed types**
(`/admin/structure/feeds`). When you add a plugin to a field, the Mislabeled
Encoding plugin should appear in the list of available tampers.
