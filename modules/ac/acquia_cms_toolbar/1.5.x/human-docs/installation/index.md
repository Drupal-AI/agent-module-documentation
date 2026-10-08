# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- **Admin Toolbar** (`admin_toolbar`) and its **Extra Tools** submodule
  (`admin_toolbar_tools`) — Drupal enables both automatically as dependencies.
  Composer pulls in the Admin Toolbar project for you.

There are no extra PHP library requirements. It is designed for an Acquia CMS site
and shares the distribution's common styling layer.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cms_toolbar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Admin Toolbar and
update any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acquia_cms_toolbar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cms_toolbar -y
```

Drupal enables `admin_toolbar` and `admin_toolbar_tools` at the same time. The
styled toolbar is active immediately — there is no required configuration.

## Verify it worked

Log in as an administrator. The admin toolbar at the top of the page expands into
drop-down menus on hover and carries the Acquia CMS styling. Click the Drupal icon
to confirm the *Flush all caches* / *Run cron* action links from Extra Tools are
present.

## Pairing with the Gin theme

If your site uses the **Gin** admin theme, also install the companion
`acquia_cms_toolbar_gin` module so the toolbar renders correctly under Gin.
