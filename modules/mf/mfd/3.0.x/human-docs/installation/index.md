# Installation

## Requirements

- **Drupal 9.4 or 10** (`core_version_requirement: ^9.4 || ^10`).
- Core's **Content Translation** (`content_translation`), **Language**
  (`language`), and **Locale** (`locale`) modules — required.
- **A core patch is required** — see below.

## Install with Composer

From the project root:

```bash
composer require drupal/mfd -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mfd -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Apply the required core patch

Because of a bug in core's `WidgetBase` class, this module will not work correctly
without a core patch — otherwise you get a
`Warning: Illegal string offset '_original_delta'` error. Apply the patch from
Drupal core issue
[#2991986](https://www.drupal.org/project/drupal/issues/2991986):

```
https://www.drupal.org/files/issues/2019-06-18/2991986-6.patch
```

Follow the standard [how to apply a patch with
Composer](https://www.drupal.org/docs/develop/using-composer/manage-dependencies#applying-patches)
instructions — typically by adding it to the `patches` section of your
`composer.json` (via `cweagans/composer-patches`) so it is reapplied on every
install.

## Enable the module

```bash
drush en mfd -y
```

## Verify it worked

Confirm the patch is applied (no `_original_delta` warning when editing a node),
then add a **Multilanguage Form Display** field to a translatable content type and
grant the **edit multilingual form** permission. Editing a node of that type should
now show the other languages' translatable fields on the single form, and saving
should store all translations at once. See the [overview](../index.md) for the full
walk-through.
