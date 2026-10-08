# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`; the release
  documented here targets `~11.3 || ~12`).
- Core's **Node**, **Taxonomy**, **Comment**, **Options**, and **History**
  modules — all enabled automatically as dependencies. (History is the
  `drupal/history` module, `~1`.)

There are no PHP library or third-party Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/forum -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the History
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/forum -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en forum -y
```

Enabling the module installs everything the board needs: the **Forums**
vocabulary, the **Forum topic** content type, the term-reference field that links
a topic to a forum, and the forum comment type for replies.

> **Note on uninstalling:** while any forum terms or topics still exist, Drupal
> blocks uninstalling the module. Delete the forum content first if you ever need
> to remove it.

## After enabling

The board has no forums yet — build the container/forum tree and set permissions.
Continue to [Configuration](../configuration/index.md).
