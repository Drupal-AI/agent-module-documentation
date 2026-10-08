# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- Core's **Custom Block** (`block_content`), **Text** (`text`) and **Options**
  (`options`) modules. Drupal enables these automatically as dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/alertbox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/alertbox -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alertbox -y
```

## Optional: modal display submodule

The project ships one submodule, **`alertbox_modal`**, which displays an alert in
a modal dialog instead of an inline banner. Enable it if you want that:

```bash
drush en alertbox_modal -y
```

## Next steps

Once enabled, configure the settings form and create your first alertbox block —
see [Configuration](../configuration/index.md).
