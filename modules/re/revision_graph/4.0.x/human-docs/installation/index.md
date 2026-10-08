# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`). If you are on
  Drupal 10, use the 3.1.x branch instead.
- No other modules are required. Content Moderation is an optional soft dependency —
  used automatically if it is present, but not required.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/revision_graph -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/revision_graph -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

To pin the 4.0.x branch specifically:

```bash
composer require "drupal/revision_graph:^4.0" -W
```

## Enable the module

```bash
drush en revision_graph -y
```

## Run the database update

4.0 adds a `revision_graph_parent` base field that records which revision each save
was derived from (this is what lets reverts show as real forks). Apply the schema
update after enabling or upgrading:

```bash
drush updb -y
```

## Verify it worked

Open a node that has more than one revision and click the **Revision Graph** tab —
you should see the revision rail with a lane per language. To adjust branch colours,
grant the **Administer Revision Graph** permission and see
[Configuration](../configuration/index.md).
