# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Views** module enabled.
- The **Salesforce Suite's Push** module (`salesforce_push`, from the
  `drupal/salesforce` project) enabled and a working Salesforce connection. Without
  it the `salesforce_push_queue` database table doesn't exist and the screen has
  nothing to show.

## Install with Composer

From the project root:

```bash
composer require drupal/salesforce_push_queue_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/salesforce_push_queue_ui -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en salesforce_push_queue_ui -y
```

This pulls in **salesforce_push** and **Views** as dependencies. Make sure the
Salesforce connection is configured (that's part of setting up the Salesforce
Suite) so entities are actually being enqueued.

## Verify the screen installed

The module ships a default view for the queue. On most sites it installs cleanly,
but there's an important caveat: the shipped view declares a config dependency on
the **View Custom Table** module, which is *not* listed as a dependency of this
module. Drupal drops config whose dependencies are unmet, so on a site **without**
`view_custom_table` the default view silently fails to install.

Check whether it's present:

```bash
drush cget views.view.salesforce_push_queue >/dev/null 2>&1 && echo present || echo MISSING
```

If it reports `MISSING`, see [Configuration](../configuration/index.md) for how to
either enable `view_custom_table` and re-import the view, or build your own view on
the queue table (all the Views data is registered regardless of whether the default
view exists).

## Permissions

This module adds **no permission of its own**. The queue screen and its reset
operations are all gated by the Salesforce Suite's **administer salesforce**
permission — grant that to the roles who should manage the queue.
