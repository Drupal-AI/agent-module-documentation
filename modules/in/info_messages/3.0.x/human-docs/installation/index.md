# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8||^9||^10||^11`).
- Core's **System** module, which is always present on a Drupal site.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/info_messages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/info_messages -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en info_messages -y
```

That is all the setup there is — the new `info` message type is available
immediately, and there is no configuration to complete.

## Verify it worked

Trigger an info message from custom code (see "How to use it" on the
[overview page](../index.md)):

```php
\Drupal::messenger()->addInfo('Hello from Info Messages.');
```

Load a page that runs that code and confirm the message appears with the module's
distinct blue "info" styling, separate from the usual status, warning, and error
colours.
