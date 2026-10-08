# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **TabPanelWidget JavaScript library, version 1.x** — this release supports
  the 1.x library only. See below for installing it with Composer.
- For the submodules: **TabPanelWidget Quick Tabs** needs the Quick Tabs project,
  and **TabPanelWidget Views** needs core's Views module.

There are no PHP extension requirements. Note that this module is not covered by
Drupal's security advisory policy.

## Install the module with Composer

From the project root:

```bash
composer require drupal/tabpanelwidget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tabpanelwidget -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Install the TabPanelWidget library

The JavaScript library is not on Packagist, so you register it as a package. If you
use **wikimedia/composer-merge-plugin**, add the module's library manifest to your
merge-plugin `include` array and run `composer update`:

```
"docroot/modules/contrib/tabpanelwidget/composer.libraries.json"
```

If you do *not* use the merge plugin, add a `package` repository to your project
`composer.json` describing the library as a `drupal-library` (name
`tabpanelwidget/tabpanelwidget`, version `1.5.0`, dist URL from the library's
GitHub releases), then require it:

```bash
composer require tabpanelwidget/tabpanelwidget:^1.5
```

## Enable the module

Enable the base module:

```bash
drush en tabpanelwidget -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **TabPanelWidget Quick Tabs** | `tabpanelwidget_quicktabs` | A TabRenderer plugin so Quick Tabs can render with the TabPanelWidget library. Requires the Quick Tabs project. |
| **TabPanelWidget Views** | `tabpanelwidget_views` | A Views style plugin so a View can be displayed as tab panels. |

For example:

```bash
drush en tabpanelwidget_views -y
```

## Verify it worked

Confirm the base module is enabled and the 1.x library is present. If you enabled
the Views submodule, edit a View and check that the TabPanelWidget style is
available; if you enabled the Quick Tabs submodule, check its renderer appears as
an option on a Quick Tabs instance.
