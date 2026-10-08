# Installation

> **Reminder:** This is a development fork bundle. For production use install the
> canonical **OAuth2 Server** (`drupal/oauth2_server`) module instead. Install
> `msso` only if you specifically need this monitoring‑SSO build, and review its
> custom code first.

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The bundled `oauth2_server` submodule relies on the **bshaffer
  `oauth2-server-php`** library, which it loads via Ludwig. Make sure that library
  is available (Ludwig can report and help install it).
- A working **HTTPS** site — OAuth2/OIDC flows must run over TLS.

There are no other module dependencies declared.

## Install with Composer

From the project root:

```bash
composer require drupal/msso -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/msso -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

The project bundles the forked `oauth2_server` module. Enable the OAuth2 server
component:

```bash
drush en oauth2_server -y
```

If the bshaffer library is missing, Ludwig will tell you — check
**Reports → Ludwig** (`/admin/reports/packages`) and follow its instructions to
download the required library, then try enabling again.

## Verify it worked

Go to **Structure → OAuth2 Servers** (`/admin/structure/oauth2-servers`). If the
overview page loads and offers to add a server, the module is enabled and you can
move on to [Configuration](../configuration/index.md).
