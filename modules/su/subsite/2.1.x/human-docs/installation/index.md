# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Book** module (`book`) — used for multi-page subsite hierarchies and
  navigation. It ships with Drupal core; you just need it enabled.
- The **Social Media Links** module (`social_media_links`) — a contributed module,
  used for the per-subsite social links override. Install it with Composer if it is
  not already present.

There are no PHP or third-party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/subsite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Social Media Links
and any shared dependencies. (Book is part of core and does not need a Composer
require.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/subsite -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en subsite -y
```

Drupal enables Book and Social Media Links at the same time as dependencies if they
are not already on.

## Verify it worked

Log in as an administrator and open **Structure → Sub Site settings**
(`/admin/structure/subsite/settings`). You should reach the settings form, where
you choose which content types can act as subsites. Continue with
[Configuration](../configuration/index.md) to add the subsite field and create your
first subsite.
