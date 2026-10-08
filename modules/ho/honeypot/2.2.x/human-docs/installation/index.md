# Installation

## Requirements

Honeypot needs **Drupal 10.3+ or 11** and has **no other module
dependencies** — it is a small, self-contained module. It is licensed
GPL-2.0-or-later.

## Install with Composer

From the project root:

```bash
composer require drupal/honeypot -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update anything it needs
to satisfy the requirement. Because Honeypot has no dependencies of its own,
this simply downloads the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/honeypot -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en honeypot -y
```

Once enabled, the settings screen appears under **Configuration → Content
authoring → Honeypot configuration**.

## Verify it worked

Log in as an administrator and go to `/admin/config/content/honeypot`. You
should see the **Honeypot configuration** page with its settings and a
**Honeypot Enabled Forms** section listing the forms on your site. If that page
loads, the module is installed correctly — next,
[configure it](../configuration/index.md) to start blocking spam.
