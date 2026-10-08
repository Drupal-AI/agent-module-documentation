# Installation

## Requirements

- **Drupal 10.4 or 11** (`core_version_requirement: ^10.4||^11`).
- The [ECA](https://www.drupal.org/project/eca) module (`eca`) — the automation
  framework the action plugs into.
- The [Message Notify](https://www.drupal.org/project/message_notify) module
  (`message_notify`) — which in turn builds on the
  [Message](https://www.drupal.org/project/message) module.

There are no external PHP library requirements. This project is minimally maintained
and not covered by Drupal's security advisory policy, so review it before relying on
it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/message_notify_eca -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in ECA and Message
Notify and update shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/message_notify_eca -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en message_notify_eca -y
```

Drupal enables the `eca` and `message_notify` dependencies automatically if they are
present.

## Verify it worked

Open the **ECA** model editor and add an action to a model — the Message Notify
notification action provided by this module should appear in the list of available
actions. If it does not, clear caches with `drush cr` and confirm both ECA and
Message Notify are enabled.
