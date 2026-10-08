# Installation

## Requirements

- **Drupal 11.2** (`core_version_requirement: ^11.2`).
- No third‑party Composer or PHP library requirements.
- To generate anything useful you'll also need one or more **generator plugins** —
  either your own (see the overview page) or the bundled example submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/generated_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/generated_content -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en generated_content -y
```

To try it out with the shipped examples, enable one of the example submodules:

```bash
drush en generated_content_example1 -y
```

> **Remember this is a development tool.** Install and run it in dev, test, or CI
> environments — not on production.

## Verify it worked

Log in as an administrator and open **Configuration → Development → Generated
content** (`/admin/config/development/generated-content`). If the page loads, the
module is installed. You can also confirm the Drush commands are available by
running `drush list` and looking for the `generated-content` commands.
