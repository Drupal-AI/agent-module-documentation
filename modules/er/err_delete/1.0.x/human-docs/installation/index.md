# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** module (enabled on virtually every site).
- You'll get the most from it on sites using **Entity Reference Revisions** /
  **Paragraphs**, since that's the composite content it's designed to delete.

## Install with Composer

From the project root:

```bash
composer require drupal/err_delete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/err_delete -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en err_delete -y
```

After enabling, grant the module's delete permission to the appropriate roles at
**People → Permissions** — keep it to trusted roles, since the operation is
destructive.

## Verify it worked

Edit a node that references other content through Entity Reference Revisions
(Paragraphs, for example). At the bottom of the edit form you should see a
**recursive delete** button. Clicking it should take you to a list of connected
items with a checkbox beside each — *don't confirm* unless you actually intend to
delete. To adjust the button's label or hide the standard delete button, see
[Configuration](../configuration/index.md).
