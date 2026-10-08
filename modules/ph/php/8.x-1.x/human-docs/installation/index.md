# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`). There is **no Drupal
  11 release**.
- Core's **Filter** module (`filter`), enabled on every standard site.

> **Before you install:** this module adds arbitrary PHP code execution to your
> site, its security advisory coverage has been **revoked**, and Drupal core removed
> this feature deliberately. Only install it if you fully understand the risk and
> have a specific, trusted‑admin‑only need. See the
> [overview page](../index.md) for the full warning and the lock‑down steps you must
> follow.

## Install with Composer

From the project root:

```bash
composer require drupal/php -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/php -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en php -y
```

## After enabling — lock it down immediately

Enabling the module does nothing on its own until you enable the PHP filter on a
text format. **Do not** add it to an existing everyday format. Instead follow the
setup and lock‑down steps on the [overview page](../index.md): create a dedicated
text format, enable the PHP evaluator filter, restrict the format to trusted roles,
and grant `use PHP for settings` only to fully trusted administrators.

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), edit your dedicated format, and confirm the **PHP
evaluator** filter is available in the **Enabled filters** list.
