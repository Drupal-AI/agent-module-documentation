# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **PHP 5.6** or newer.
- A **CINNOX account** and your widget identifier / snippet. CINNOX is a
  third-party service; sign up at [cinnox.com](https://www.cinnox.com) (a free
  trial is available).

There are no additional Composer or PHP library requirements.

> **Note:** this module is not covered by Drupal's security advisory policy, and
> its listed core support stops at Drupal 10. Check compatibility before using it
> on Drupal 11.

## Install with Composer

From the project root:

```bash
composer require drupal/cinnox -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cinnox -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cinnox -y
```

Enabling the module alone changes nothing visible — the widget only appears once
you enter your CINNOX details on the settings form. See
[Configuration](../configuration/index.md).

## Verify it worked

After you have configured the widget, open any public page as an anonymous
visitor. The CINNOX chat/call launcher should appear (typically floating in a
corner). It should **not** appear on admin pages. If it does not show up, revisit
the settings form and confirm the widget ID is filled in correctly.
