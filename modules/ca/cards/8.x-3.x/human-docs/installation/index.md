# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Entity Reference view mode** module (`entityreference_view_mode`) — required.
  Cards uses it to choose the view mode for referenced child cards.

There are no additional PHP or third-party library requirements.

> **Security advisory coverage:** this project is **not covered** by Drupal's
> security advisory policy. Keep it up to date and review it yourself before relying
> on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/cards -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Entity Reference view mode module is pulled in as a
dependency if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cards -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cards -y
```

Enabling Cards also enables its `entityreference_view_mode` dependency if it is not
already on.

## Verify it worked

On a block content type (or another fieldable entity), add a **Cards** field and
configure its widget and formatter on the *Manage form display* and *Manage display*
pages. Create an entity using that bundle and confirm it renders wrapped as a card.
The full workflow is in "How to use it" on the [overview page](../index.md).
