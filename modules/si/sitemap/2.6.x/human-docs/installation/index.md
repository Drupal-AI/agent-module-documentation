# Installation

## Requirements

Sitemap needs:

- **Drupal 10.2+ or 11** (`^10.2 || ^11`).
- **PHP 8.1 or newer** (`>=8.1`).

The module has no other contrib dependencies — the core sitemap sections (front
page, menus, vocabularies) work out of the box. Two optional submodules ship with
the project and add extra section types:

- **Sitemap book** (`sitemap_book`) — lists book outlines on the sitemap. Enable
  it only if you use core's **Book** module.
- **Sitemap metatag** (`sitemap_metatag`) — adds meta tags to the sitemap page.
  Requires the contrib **Metatag** module.

## Install with Composer

From the project root:

```bash
composer require drupal/sitemap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sitemap -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sitemap -y
```

To turn on the optional submodules as well, add their machine names:

```bash
drush en sitemap sitemap_book -y
```

## The sitemap page and who can see it

Once enabled, the module publishes a human-readable overview page at **`/sitemap`**
(you can change this path later — see [Configuration](../configuration/index.md)).

Who is allowed to open that page is controlled by the **"View published Sitemap
page"** permission (`access sitemap`). Out of the box no role has it, so grant it
to the roles that should be able to view the page — for example, to let every
signed-in visitor see it:

```bash
drush role:perm:add authenticated 'access sitemap'
```

To let anonymous visitors see it too, grant the same permission to the
`anonymous` role. You can also set these at **People → Permissions**
(`/admin/people/permissions`).

## Verify it worked

Log in as an administrator and go to **Configuration → Search and metadata →
Sitemap** (`/admin/config/search/sitemap`). You should see the **Sitemap**
settings page with **View**, **Settings**, and **Translate sitemap** tabs:

![The Sitemap settings page after installation](../images/settings.png)

If that page loads, the module is installed correctly. Next, work through the
[configuration](../configuration/index.md) to choose what appears on the page,
then visit `/sitemap` to see the result.
