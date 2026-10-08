# Installation

## Requirements

- **Drupal 10.4 or 11.1** (`core_version_requirement: ^10.4 || ^11.1`).
- **PHP 8.1** or newer.
- Optional: **Drush 11** or newer, if you want to run rebuilders from the command
  line.

There are no third‑party Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/rebuilder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rebuilder -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

For Drush‑only use, the base module is all you need:

```bash
drush en rebuilder -y
```

To also get the admin form for running rebuilders from the browser, enable the
included **Rebuilder UI** submodule as well. The easiest way is on the **Extend**
page (`/admin/modules`): find the Rebuilder UI submodule under the Rebuilder
project and tick it, then **Install**. (You can also enable it with
`drush en <submodule_machine_name> -y` if you know its machine name.)

## Verify it worked

From the command line, list the available rebuilders:

```bash
drush rebuilder:list
```

You should see the built‑in rebuilder plugins. If you enabled the UI submodule,
also visit **Configuration → Development → Performance → Rebuilder**
(`/admin/config/development/performance/rebuilder`) and confirm the form loads.
See the [main guide](../index.md#how-to-use-it) for running a rebuilder.
