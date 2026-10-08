# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The [Message](https://www.drupal.org/project/message) module (`message`).

There are no external PHP library requirements. **Note:** this is an early alpha
release that the maintainers say is not yet ready for production, and it is not
covered by Drupal's security advisory policy — evaluate it accordingly.

## Install with Composer

From the project root:

```bash
composer require drupal/message_recipient -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Message
dependency and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/message_recipient -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en message_recipient -y
```

## Enable the UI submodule (recommended)

To manage recipient collectors on message templates through the admin interface,
enable the bundled UI submodule:

```bash
drush en message_recipient_ui -y
```

Without this submodule, recipient collection is available mainly through the module's
service and configuration rather than a point-and-click UI.

## Verify it worked

With `message_recipient_ui` enabled, edit a message template — you should be able to
add recipient collectors to it. If you are integrating programmatically, confirm the
recipient-collection service is available and see the module's `README` for usage
examples.
