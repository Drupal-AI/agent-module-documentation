# Installation

## Requirements

Entity Usage needs **Drupal 10.3+ or 11** (core version requirement
`^10.3 || ^11`). It has **no other module dependencies** — nothing extra is
pulled in when you install it, and there are no submodules.

The module *integrates* with several contrib modules when they happen to be
present (Entity Embed, LinkIt, Block Field, Entity Reference Revisions, Dynamic
Entity Reference, Layout Builder, and so on), but none of them are required to
install or use Entity Usage. Its built-in tracking of entity_reference fields,
link fields, and HTML links in text works with core alone.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_usage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_usage -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_usage -y
```

Once enabled, the configuration screens appear under **Configuration → Content
authoring → Entity Usage Settings** (`/admin/config/entity-usage/settings`).

## Back-fill usage for existing content

Entity Usage records relationships **as entities are saved**. Immediately after
installing, the usage table only reflects content that has been saved *since*
the module was enabled — everything created earlier is not yet tracked.

To catch up your existing content, do one of the following:

- **Re-save the content** — opening an entity's edit form and saving it makes
  the module record its references. This is fine for a handful of items.
- **Rebuild the whole usage table** — for a site with real content, regenerate
  everything at once. Use the batch-update form at
  `/admin/config/entity-usage/batch-update` (the **Batch Update** tab on the
  settings page), which erases and recreates all tracking records, or run the
  Drush equivalent, which is preferable on large sites:

  ```bash
  drush entity-usage:recreate
  ```

Run the same rebuild any time you change which source or target types are
tracked, enable or disable tracking methods, or bulk-import content — see
[Configuration](../configuration/index.md).

## Verify it worked

Log in as an administrator and go to
`/admin/config/entity-usage/settings`. You should see the **Entity Usage
Settings** page with **Settings** and **Batch Update** tabs:

![The Entity Usage Settings page](../images/settings.png)

If that page loads, the module is installed correctly. Next, review the
[configuration](../configuration/index.md) to choose what gets tracked and where
the **Usage** tab appears.
