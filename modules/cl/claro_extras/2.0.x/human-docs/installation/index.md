# Installation

## Requirements

- **Drupal 9.1 or 10** (`core_version_requirement: ^9.1 || ^10`).
- The **Claro** admin theme in use — the module's enhancements only take effect
  when Claro is your active admin theme. Claro ships with Drupal core.
- No other module dependencies. The Paragraph-title enhancement is only meaningful
  if you use the Paragraphs module.

There are no third-party Composer packages or external libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/claro_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/claro_extras -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en claro_extras -y
```

## Verify it worked

Go to **Appearance → Settings → Claro Extras**
(`/admin/appearance/settings/claro_extras`) and confirm the settings form loads.
Turn on the options you want (see [Configuration](../configuration/index.md)), then
edit a node and check the effect — for example the meta block appearing as vertical
tabs beneath the form. Remember the changes only show when Claro is your admin
theme.
