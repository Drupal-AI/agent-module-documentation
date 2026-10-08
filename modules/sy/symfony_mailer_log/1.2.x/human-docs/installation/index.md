# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **Symfony Mailer** module (`drupal/symfony_mailer` `^1.3 || ^2.0`) enabled —
  this is the mail system Mailer Plus log hooks into, and it is a hard dependency.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/symfony_mailer_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and will pull in `drupal/symfony_mailer` if it is not already
present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/symfony_mailer_log -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en symfony_mailer_log -y
```

There are no submodules. Enabling the module gives you the settings form and the
"Log email" adjuster, but **no mail is logged until you add that adjuster to a Mailer
policy** — see [Configuration](../configuration/index.md).

## Grant the permissions

At **People → Permissions**, decide who can see and manage logged mail — see
[Configuration](../configuration/index.md#permissions). Because log entries can hold
full email bodies and recipient addresses, grant the "view" permission carefully.
