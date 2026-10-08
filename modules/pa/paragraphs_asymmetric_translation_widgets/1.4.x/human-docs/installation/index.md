# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The **Paragraphs** module (`drupal/paragraphs`, `~1.15`) — installed
  automatically by Composer.
- Core's **Content Translation** module (`content_translation`) — enabled as a
  dependency.
- A multilingual site (the **Language** module and at least two languages) for the
  behaviour to be meaningful.

There are no PHP library or third-party Composer requirements beyond Paragraphs.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_asymmetric_translation_widgets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require
> drupal/paragraphs_asymmetric_translation_widgets -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_asymmetric_translation_widgets -y
```

Drupal enables Paragraphs and Content Translation at the same time as
dependencies.

## After enabling

There is no configuration form. To turn the behaviour on, mark your paragraphs
reference field **translatable** and select the module's widget on the content
type's **Manage form display** — see the [overview](../index.md) for the exact
steps.
