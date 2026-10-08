# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Advanced Queue** module (`advancedqueue`) — this module sends
  notifications for its jobs and depends on it.
- Optionally, the **Symfony Mailer** module if you want to use the
  `advancedqueue_mail_symfony_mailer` submodule.

## Install with Composer

From the project root:

```bash
composer require drupal/advancedqueue_mail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Advanced Queue if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/advancedqueue_mail -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advancedqueue_mail -y
```

Enabling it also enables the Advanced Queue dependency if it is not already on.

## Optional submodule

**Advanced Queue Mail Symfony Mailer** (`advancedqueue_mail_symfony_mailer`)
integrates the notifications with the Symfony Mailer module. Enable it only if you
send mail through Symfony Mailer:

```bash
drush en advancedqueue_mail_symfony_mailer -y
```

After enabling, configure which job events send mail and to which operator
addresses — see the [overview](../index.md#how-to-use-it).
