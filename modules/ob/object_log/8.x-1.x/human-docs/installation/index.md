# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The **Devel** module (`drupal/devel`) — Object Log depends on it, and its report
  pages reuse Devel's **access devel information** permission.

Since this is a debugging aid, install it in your development or staging
environment and leave it out of production.

## Install with Composer

From the project root:

```bash
composer require drupal/object_log -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Devel and any other
shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/object_log -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.
>
> If you only want it in development, require it as a dev dependency:
> `ddev composer require --dev drupal/object_log -W`.

## Enable the module

```bash
drush en object_log -y
```

Drupal will enable Devel as a dependency if it isn't already on.

## Verify it worked

Add a quick `object_log('test', ['hello' => 'world']);` call somewhere in a code
path you can trigger (or run it via `drush php:eval "object_log('test', ['hello' =>
'world']);"`), then visit **Reports → Object log** (`/admin/reports/object_log`) as
a user with the **access devel information** permission. Your `test` entry should
appear in the list, ready to inspect.
