# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other contrib modules are required.
- The toolbar relies on the **markItUp!** JavaScript library. The module can
  fetch and build the third-party editor assets for you via its Drush command
  (see below), so you do not have to download them by hand.

## Install with Composer

From the project root:

```bash
composer require drupal/texbar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/texbar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en texbar -y
```

## Fetch the editor assets

LaTeX Toolbar ships a Drush command that can fetch and build the third-party
markItUp editor assets it needs. Run the module's Drush command after enabling
if the toolbar's buttons do not appear — this pulls in the required JavaScript
library.

## Verify it worked

Grant yourself the `administer texbar` permission, then open
**Configuration → Content authoring → LaTeX Toolbar**
(`/admin/config/content/texbar`) and set a selector (see
[Configuration](../configuration/index.md)). Edit a page whose textarea matches
that selector — the LaTeX button toolbar should appear above the field, and
clicking a button should insert its LaTeX code into the textarea.
