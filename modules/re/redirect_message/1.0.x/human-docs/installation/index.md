# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The contrib **[Redirect](https://www.drupal.org/project/redirect)** module
  (`redirect`) — Redirect Message attaches its message to the redirects Redirect
  manages, so it is required.
- Core's **Options** and **Text** modules, which supply the message-type and
  formatted-text fields. Both ship with core.

All dependencies are pulled in / enabled with the `-W` flag and `drush en` below.
There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/redirect_message -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Redirect
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/redirect_message -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en redirect_message -y
```

Drupal enables the Redirect, Options, and Text modules automatically as
dependencies if they are not already on.

## Verify it worked

Edit any redirect at `/admin/config/search/redirect`. The add/edit form should now
include a **Message** field and a **Message type** selector. Set a message, save,
then trigger the redirect in a browser and confirm the message appears on the
destination page.
