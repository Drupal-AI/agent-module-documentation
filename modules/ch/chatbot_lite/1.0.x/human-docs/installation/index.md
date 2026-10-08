# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).

There are no module dependencies and no PHP library requirements. Nothing external
is contacted at runtime.

## Install with Composer

From the project root:

```bash
composer require drupal/chatbot_lite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/chatbot_lite -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en chatbot_lite -y
```

## Verify it worked

Visit the settings form at `/admin/config/system/chatbot_lite` to confirm the
module is active, then add a Q&A pair (see [Configuration](../configuration/index.md))
and open the chat form at `/chatbot_lite_form` to check it answers.
