# Installation

## Requirements

- **Drupal 8.8 through 12** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11 || ^12`).
- No other modules are required. The module uses the
  [Print.js](https://printjs.crabbly.com/) JavaScript library for printing.

The module is covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/printjs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/printjs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en printjs -y
```

## Verify it worked

After enabling, visit the settings form at `/admin/config/…/printjs` and confirm the
**id** setting is present (default `print`) — see
[Configuration](../configuration/index.md). Then wrap some content in a
`<div id="print"> … </div>`, place the **Printjs** block, and click the **Print**
button: the browser's print dialog should open showing only that content.
