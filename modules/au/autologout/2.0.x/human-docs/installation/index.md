# Installation

## Requirements

Automated Logout runs on **Drupal 9.2, 10, or 11** (`^9.2 || ^10 || ^11`). It
has no other Drupal module dependencies, but it does rely on one Composer
library, which Composer pulls in automatically:

- **js_cookie** (`drupal/js_cookie`) — the JavaScript cookie helper the module
  uses to track the inactivity timer in the browser.

## Install with Composer

From the project root:

```bash
composer require drupal/autologout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install or update the
`js_cookie` dependency as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/autologout -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autologout -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → People → Automated
logout** (`/admin/config/people/autologout`). You should see the **Automated
logout settings** form:

![The Automated logout settings form](../images/settings.png)

If the page loads and the settings form is present, the module is installed
correctly. Next, review the [configuration](../configuration/index.md) to set
your inactivity timeout and warning message.
