# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No module dependencies, and no third-party Composer or front-end library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/debug_bar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/debug_bar -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en debug_bar -y
```

> **Development only.** Prefer enabling Debug Bar on local and staging
> environments, not production. If you must install it on a production site, be
> especially careful with the view permission below — the bar can expose internal
> information.

## Grant permissions

The bar is only visible to users who hold the right permission, so this step is
part of installation, not optional tuning:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Grant **View debug bar** (`view debug bar`) to your trusted developer or
   administrator role(s) only.
3. Grant **Administer debug bar** (`administer debug bar`) to administrators.

## Verify it worked

Log in as a user with the **View debug bar** permission and load any page — the
floating debug toolbar should appear. Log in as (or preview the site as) a user
*without* that permission and confirm the bar is hidden; that's your check that
the bar isn't leaking to untrusted visitors.
