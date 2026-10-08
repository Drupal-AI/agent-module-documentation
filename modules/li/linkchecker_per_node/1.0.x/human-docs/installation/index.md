# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Link Checker** contrib module (`linkchecker`) — this module extends it
  and reads its data. Install and enable Link Checker first.
- Core's **Views** module (enabled by default) — the report is a View.

> **Security-advisory note:** this module is **not covered** by Drupal's
> security advisory policy at the documented version. Review it yourself before
> using it on a production site.

## Install with Composer

First make sure Link Checker is present, then require this module. From the
project root:

```bash
composer require drupal/linkchecker_per_node -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/linkchecker_per_node -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en linkchecker_per_node -y
drush cr
```

Enabling it installs the `broken_links_per_node_report` View and adds the
**Broken Links** tab to node pages. A cache rebuild (`drush cr`) makes the new
local task appear.

## Grant the report permission

Go to **People → Permissions** and grant **View broken links per node** to the
roles that should be able to open the report tab.

## Verify it worked

Open any node (ideally one you know contains a broken link that Link Checker has
already flagged). You should see a **Broken Links** local task tab; clicking it
takes you to `node/{node}/broken-links` and shows the broken-link table for that
node.
