# Installation

## Requirements

- **Drupal 9 or newer** (`core_version_requirement: >=9`).
- Core's **Content Moderation** module (`content_moderation`) — its only dependency —
  with a workflow applied to the content whose drafts you want to protect.

Drupal will enable Content Moderation automatically as a dependency. There are no
third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_moderation_node_grants -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_moderation_node_grants -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_moderation_node_grants -y
```

## Rebuild node access

Because this module changes how node access grants are calculated, you must rebuild
the node access records so existing content is covered:

```bash
drush php:eval "node_access_rebuild();"
```

You can also trigger a rebuild from **Reports → Status report** if Drupal flags that
node access permissions need rebuilding. Skipping this step means existing content
won't yet reflect the module's grants.

## Set the unpublished-content permissions

At **People → Permissions** (`/admin/people/permissions`), grant the unpublished
content permissions to the appropriate roles — for example *view own unpublished
content* for authors and *view any unpublished content* for reviewers.

## Verify it worked

Create an unpublished (draft) node and request it as an anonymous visitor — it should
return **403 (access denied)**, confirming drafts are not leaked. Then confirm that a
user with the appropriate *view unpublished* permission can see it. Remember that
node access is additive: if another node-access module also grants view on the same
content, that grant applies too, so check the combined outcome on your site.
