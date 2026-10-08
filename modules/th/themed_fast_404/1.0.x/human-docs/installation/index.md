# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Config** (`config`) and **File** (`file`) modules, both of which
  Drupal enables automatically as dependencies.

There are no third-party Composer packages and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/themed_fast_404 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/themed_fast_404 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en themed_fast_404 -y
```

## Run cron — required

This step is easy to miss but important. The moment the module is enabled it
changes core's fast-404 behaviour, but the **themed** static page doesn't exist
yet — it's generated on cron. Until you run cron, missing URLs fall back to
core's plain default 404 HTML. So run cron once right away:

```bash
drush cron
```

That generates `public://page-not-found-{langcode}.html` for each enabled
language. On a multilingual site, adding another language later requires another
cron run before that language gets its themed 404.

## Verify it worked

Request any URL that doesn't exist and confirm you get your themed markup with a
404 status:

```bash
curl -si https://example.com/this-path-does-not-exist | head -20
```

Also confirm image style derivatives still work (they're deliberately excluded
from the fast-404 handling):

```bash
curl -sI https://example.com/sites/default/files/styles/thumbnail/public/x.jpg | head -3
```

If the 404 body comes back empty, the cron fetch couldn't reach the page — see
the **Base URL** field and the "empty file" note in
[Configuration](../configuration/index.md).

## Uninstall

Uninstalling the module removes the config override, so core reverts to whatever
is stored in `system.performance`. The generated `page-not-found-*.html` files are
left behind in `public://`; delete them by hand if you want them gone.
