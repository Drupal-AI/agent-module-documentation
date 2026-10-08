# Installation

## Requirements

REST UI runs on **Drupal 9.5, 10, or 11**. It depends on one core module, which
Drupal enables automatically:

- **RESTful Web Services** (`rest`) — core's module that actually exposes resources
  over a RESTful API. REST UI is only its admin interface, so this module does the
  real work.

In practice you also want core's **Serialization** module enabled, since it provides
the `json`, `xml`, and `hal_json` formats that resources are served in. REST UI has
no other contrib dependencies.

> **REST UI is an admin convenience only.** It defines no resources and serves no
> requests itself — the serving is done by core **REST** plus **Serialization**.
> REST UI simply gives you a form for the configuration those modules read.

## Install with Composer

From the project root:

```bash
composer require drupal/restui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/restui -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en restui -y
```

This also enables core's `rest` module if it is not already on.

## Verify it worked

Log in as an administrator and go to **Configuration → Web services → REST**
(`/admin/config/services/rest`). You should see the **REST resources** screen with an
**Enabled** section and a **Disabled** section listing the available resources:

![The REST resources list after installation](../images/list.png)

If the page loads and the two sections are present, the module is installed
correctly. Next, [enable and configure a resource](../configuration/index.md).
