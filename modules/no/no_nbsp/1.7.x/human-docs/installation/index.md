# Installation

## Requirements

No Non-breaking Space Filter is self-contained:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No third-party Composer or PHP library requirements, and no other contrib
  modules. It builds on core's Filter and Field systems, which are always present.

## Install with Composer

From the project root:

```bash
composer require drupal/no_nbsp -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/no_nbsp -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en no_nbsp -y
```

There is nothing to configure globally. Once enabled, the **No Non-breaking Space
Filter** becomes available as a filter on your text formats and as a formatter on
text fields — see the [overview](../index.md#how-to-use-it) for how to turn it on.

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), edit any format, and look under **Enabled
filters** — **No Non-breaking Space Filter** should appear in the list.
