# Installation

## Requirements

LocalGov Page Components needs **Drupal 10 or 11**
(`core_version_requirement: ^10 || ^11`) and several contrib modules, which
Composer installs for you:

- **Paragraphs** (`drupal/paragraphs` `^1.11`) — and its **Paragraphs library**
  submodule, which provides the reusable-items feature this module re-labels.
- **Entity Browser** (`drupal/entity_browser` `^2.5`) — and its **Entity Browser
  Entity Form** submodule, for the modal select/create browser.
- **Inline Entity Form** (`drupal/inline_entity_form` `^1.0-rc6 || ^3.0`).
- **LinkIt** (`drupal/linkit` `^6.1 || ^7.0`) — for the rich-text link integration.
- **LocalGov Core** (`drupal/localgov_core` `^2.14 || ^3.0`).

The **Paragraphs library** and **Entity Browser Entity Form** submodules must be
enabled (Drupal enables required dependencies automatically).

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_page_components -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update all of
the contrib dependencies above as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_page_components -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_page_components -y
```

This enables the required Paragraphs library, Entity Browser, Inline Entity Form,
and LinkIt dependencies too. It installs the `localgov_page_components` field
*storage* and (when its supporting View is present) the `page_components` Entity
Browser.

## Optional submodule — workflow

The **`localgov_page_components_workflow`** submodule adds content-moderation
cascade behaviour, gating component changes behind node publication. Enable it only
if you use content moderation:

```bash
drush en localgov_page_components_workflow -y
```

## After enabling

There's no settings page. To start building pages from components:

1. Add a field instance using the `localgov_page_components` storage to your
   content type (**Manage fields**).
2. Set that field's widget to **Entity browser** → `page_components` (**Manage form
   display**).
3. Optionally configure the **LinkIt** integration.

See the [overview](../index.md) for the full walkthrough.
