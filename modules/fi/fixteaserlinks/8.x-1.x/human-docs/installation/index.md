# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).

There are no third‑party Composer or PHP library requirements. The optional
*advanced_help_hint* module can add inline help text on the module's help page,
but it is not required.

## Install with Composer

From the project root:

```bash
composer require drupal/fixteaserlinks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fixteaserlinks -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fixteaserlinks -y
```

## Rebuild caches

Fix Teaserlinks's behaviour is cache‑sensitive. After enabling it — and after
every change to its settings — rebuild the caches so the change takes effect:

```bash
drush cr
```

## A note on uninstalling

If you later uninstall the module and hit an exception or a white screen, delete
the file `fixteaserlinks.install` from the module directory before uninstalling.
This is a known quirk of the Drupal 8 branch.

## Verify it worked

Out of the box the module does nothing until you switch a setting on — by default
all its options are off. Head to
[Configuration](../configuration/index.md) to choose which teaser links to hide,
then reload a page that shows node teasers to confirm the links disappear.
