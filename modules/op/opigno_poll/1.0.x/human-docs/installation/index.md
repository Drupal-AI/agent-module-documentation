# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Twig Tweak** (`twig_tweak`) — pulled in automatically as a dependency.
- **Opigno LMS** (`opigno_lms`) — this is the notable one: Opigno Poll depends on
  the Opigno LMS distribution, which is a large dependency. The module is intended
  for sites already running Opigno, so plan to install it there rather than on a
  plain Drupal site.

There are no extra PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/opigno_poll -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Twig Tweak, the
Opigno LMS packages, and any shared dependencies they need.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/opigno_poll -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en opigno_poll -y
```

Enabling Opigno Poll also enables Twig Tweak and the Opigno LMS dependency if they
are not already on.

## Verify it worked

Log in as an administrator and visit `/admin/content/opigno_poll` — you should see
the (initially empty) poll listing. Add your first poll at `/opigno_poll/add`, then
open it at `/opigno_poll/{id}` to confirm the voting form renders. See the
[main guide](../index.md) for how to configure a poll and place the result blocks.
