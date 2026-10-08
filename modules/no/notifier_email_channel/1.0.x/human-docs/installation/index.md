# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Notifier** module (`notifier`) — a required dependency, which itself
  requires PHP 8.3.
- A working outbound **mail setup** on your site, since delivery goes through
  Symfony Mailer.

## Install with Composer

From the project root:

```bash
composer require drupal/notifier_email_channel -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and will bring in Notifier if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/notifier_email_channel -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en notifier_email_channel -y
```

Enabling this module enables Notifier as well if it is not already on.

## Verify it worked

Send a test notification through Notifier to a recipient whose inbox you can
check. If the email arrives, the channel is delivering correctly. If it does not,
confirm that your site's mail transport works for ordinary Drupal email first —
the email channel relies on it.
