# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other module dependencies, and no third-party PHP libraries.
- **Optional but often useful:** the **Config Ignore** module, if you want to
  manage the served files directly on production without a config import
  overwriting them.

## Install with Composer

From the project root:

```bash
composer require drupal/serve_plain_file -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/serve_plain_file -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en serve_plain_file -y
```

## Verify it worked

After enabling, grant the **Administer served files** permission to your role (see
[Configuration](../configuration/index.md)), then visit
**`/admin/config/system/served_files`**. Add a test file with a path and some
content, save it, and load that path in your browser — the content you entered
should be served there.
