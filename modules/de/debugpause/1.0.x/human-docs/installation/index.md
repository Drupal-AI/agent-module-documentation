# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Admin Toolbar** module (`admin_toolbar`) — required, since the pause button
  lives in the admin toolbar. Composer pulls it in as a dependency.
- Your browser's **DevTools must be open** for the pause to take effect — this is a
  runtime prerequisite, not an install step, but it's the most common reason the
  button "does nothing".

There are no third-party Composer or front-end library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/debugpause -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Admin Toolbar and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/debugpause -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en debugpause -y
```

Drupal will enable Admin Toolbar as a dependency if it isn't already on.

> **Development only.** Enable this on local or staging environments and keep the
> permission restricted to developers.

## Grant the permission

The button is hidden from anyone without the right permission, so grant it before
you expect to see it:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Grant **Use debug pause** (`use debug pause`) to your developer role(s).

## Verify it worked

Log in as a user with the **Use debug pause** permission and look at the admin
toolbar — you should see the Debug Pause button. Open your browser's DevTools,
click the button, and after the configured delay JavaScript execution should pause.
Adjust the delay on the [Configuration](../configuration/index.md) page to suit
your workflow.
