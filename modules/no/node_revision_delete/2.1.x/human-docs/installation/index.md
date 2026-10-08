# Installation

## Requirements

Node Revision Delete needs **Drupal 10.3+ or 11**. Its only Drupal dependency is
core's **Node** module (`node`), which is already enabled on any site that has
content types — so there is nothing extra to download.

## Install with Composer

From the project root:

```bash
composer require drupal/node_revision_delete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_revision_delete -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_revision_delete -y
```

Once enabled, the settings screen appears under **Configuration → Content
authoring → Node Revision Delete** (`/admin/config/content/node_revision_delete`).

## How deletion happens

The module never deletes revisions the instant you save your settings. Instead it
finds the surplus revisions, queues them, and deletes them on **cron**. So for
pruning to actually run, your site needs cron to be firing regularly (Drupal's
automated cron, a system crontab, or `drush cron`). You can also trigger a run by
hand from the **Queue** tab.

For scripted or scheduled maintenance, the module ships two Drush commands:

```bash
# Queue every node of a content type for revision deletion, per its rules.
drush node-revision-delete:queue --type=article

# Delete all prior revisions of node 123 before revision 4567.
drush node-revision-delete:delete-prior-revisions 123 4567
```

Queued items are then processed by cron, or immediately with `drush queue:run`.

## Verify it worked

Log in as an administrator and go to
`/admin/config/content/node_revision_delete`. You should see the **Node Revision
Delete** page with a **Settings** tab listing your content types and a **Queue**
tab. If that page loads, the module is installed correctly. Next, set your
retention rules on the [Configuration](../configuration/index.md) page.
