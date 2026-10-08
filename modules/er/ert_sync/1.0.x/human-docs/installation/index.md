# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- A multilingual setup is assumed — pair it with core's **Content Translation**
  (`content_translation`) module and translatable entity‑reference fields, since
  that is the scenario the module is built for.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ert_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ert_sync -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ert_sync -y
```

There is no configuration to do — the sync runs automatically whenever a node is
saved.

## Verify it worked

On a staging copy, open a translated node that has an entity‑reference field, set a
reference value on the source translation, and save. Check the node's other
translations — the reference value should have been propagated (into empty targets
by default), and you should have seen a batch progress/completion message during
the save.
