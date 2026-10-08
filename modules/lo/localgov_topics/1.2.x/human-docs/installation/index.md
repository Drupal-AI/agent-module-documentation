# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`), which Drupal enables as a dependency.
- Optional: core's **Views** module, if you want the bundled Topics
  reference-selection view (it installs as optional config only when Views is
  present).
- Optional: the **LocalGov Roles** module (`localgov_roles`) if you want LocalGov
  Editors automatically granted the topic-term permissions.

This module is designed for the **LocalGovDrupal** distribution but depends only
on core Taxonomy, so it works on a plain Drupal site too.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_topics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_topics -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_topics -y
```

Enabling the module creates the **Topic** vocabulary, the
`localgov_topic_classified` node field storage, and (if Views is present) the
**Topics** view. There are no submodules. Next, attach the topic field to your
content types — see [Configuration](../configuration/index.md).
