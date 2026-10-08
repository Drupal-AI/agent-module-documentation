# Installation

## Requirements

RobotsTxt needs **Drupal 9.3+, 10, or 11** (`drupal/core: ^9.3 || ^10 || ^11`). It
has no other module dependencies and requires no additional libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/robotstxt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update related packages as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/robotstxt -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en robotstxt -y
```

Once enabled, the settings page appears under **Configuration → Search and metadata
→ RobotsTxt** (`/admin/config/search/robotstxt`).

## Crucial step: remove the physical robots.txt

This step is easy to miss and the module will **not work without it.**

Drupal ships a static `robots.txt` file in the docroot (the site root). Your web
server serves that file directly, before Drupal's dynamic route ever runs — so as
long as the physical file exists, the module's `/robots.txt` route is never
reached and your admin-UI content is ignored.

To let RobotsTxt take over, **delete or rename** the physical file:

```bash
rm robots.txt
# or, to keep a backup:
mv robots.txt robots.txt.bak
```

Run this from the Drupal root (the docroot). With DDEV, run it on your host from
the project's docroot, or inside the container with `ddev ssh` first.

> **Re-check after core updates.** Updating Drupal core can restore the static
> `robots.txt`. If crawler rules you set in the UI suddenly stop appearing at
> `/robots.txt`, check whether the physical file has come back and remove it again.

## Verify it worked

Log in as an administrator and go to `/admin/config/search/robotstxt`. You should
see the **RobotsTxt** settings page with a **Contents of robots.txt** textarea and
a **Save configuration** button.

Then visit `/robots.txt` in your browser. If it shows the content from the admin
form (rather than a leftover static file), the dynamic route is working and you are
ready to [edit the contents](../configuration/index.md).
