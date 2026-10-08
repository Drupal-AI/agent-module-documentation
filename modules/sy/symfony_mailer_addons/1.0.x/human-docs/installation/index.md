# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Symfony Mailer** module (`symfony_mailer`) — this is a hard dependency;
  install and enable it if you have not already.
- No third-party PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/symfony_mailer_addons -W
```

The Composer package name (`drupal/symfony_mailer_addons`) matches the module's
machine name (`symfony_mailer_addons`). The `-W` (`--with-all-dependencies`)
flag lets Composer update any shared dependencies as needed, and pulls in
Symfony Mailer if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/symfony_mailer_addons -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en symfony_mailer_addons -y
```

## Set permissions

The module adds an **administer mail footer links** permission that controls
access to the footer-links form. Grant it only to trusted roles on **People →
Permissions** (`/admin/people/permissions`).

## Next steps

Head to [Configuration](../configuration/index.md) to define your footer links
and, if you want them, attach the template-suggestion or legacy-body adjusters
to a Symfony Mailer policy.
