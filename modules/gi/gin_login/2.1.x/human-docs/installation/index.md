# Installation

## Requirements

Gin Login needs **Drupal 10.2+ or 11**. Its one important dependency is not another
module but a **theme**:

- **Gin admin theme** (`gin`) — Gin Login styles the login pages to match Gin and
  reuses Gin's own libraries and settings (accent color, focus color, dark mode,
  high-contrast mode). For the login screen to render its full styling, the **Gin
  theme must be installed and set as your site's administration theme**.

If Gin is not installed, install and enable it first:

```bash
composer require drupal/gin -W
drush theme:enable gin
drush config:set system.theme admin gin -y
```

The last command sets Gin as the admin theme. You can also do this in the UI at
**Appearance** (`/admin/appearance`): install Gin, then set it as the
administration theme.

## Install Gin Login with Composer

From the project root:

```bash
composer require drupal/gin_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gin_login -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gin_login -y
```

Once enabled, the configuration screen appears under **Configuration → System → Gin
Login** (`/admin/config/system/configuration/gin-login`).

## Verify it worked

1. Log in as an administrator.
2. Open `/admin/config/system/configuration/gin-login`. You should see the **Gin
   Login Configuration Form** with a **Logo** section and a **Wallpaper** section.
3. Open `/user/login` (you may want to do this in a private/incognito window, since
   you are logged in). The login form should now appear on a Gin-styled card with a
   wallpaper beside it.

If the login page still looks like your front-end theme, confirm that the Gin theme
is installed and set as the admin theme (see **Requirements** above). Next, head to
[Configuration](../configuration/index.md) to set your own logo and wallpaper.
