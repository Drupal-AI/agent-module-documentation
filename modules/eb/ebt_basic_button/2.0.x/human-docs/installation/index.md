# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- **EBT Core** (`drupal/ebt_core ^2.0`) — the shared Extra Block Types foundation that
  holds the button/colour machinery and the site-wide defaults. Required.
- The **Paragraphs** module (`drupal/paragraphs ^1.0`).
- Core **Link** (`link`) module.

Composer installs all of these for you. There are no other third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/ebt_basic_button -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install EBT Core, Paragraphs,
and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ebt_basic_button -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ebt_basic_button -y
```

This enables EBT Core and Paragraphs as dependencies and creates the **EBT Basic
Button** block content type.

## Standalone use

You don't have to install the rest of the Extra Block Types suite — EBT Basic Button
works on its own, as long as EBT Core is present (it always is, as a dependency).

## After enabling

There's no settings form for this module. Set your brand colours and breakpoints once
in **EBT Core** at **Configuration → Content authoring → Extra Block Types (EBT)
settings** (`/admin/config/content/ebt-settings`), then start creating button blocks —
see the [overview](../index.md#how-to-use-it) for the walkthrough.
