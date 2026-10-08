# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core **Node**, **Taxonomy**, and **Media** modules.
- **Migrate Plus** (`migrate_plus`) and **Migrate Tools** (`migrate_tools`) — the
  import runs on Drupal's Migrate framework. Composer pulls these in
  automatically.
- A **Content Workflow (by Bynder)** account and **API credentials**. A free
  trial account can be created on Bynder's site.
- The module uses a custom library for API communication, which is why installing
  via Composer is the recommended path — it brings the library and dependencies
  in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/content_workflow_bynder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including the Migrate Plus / Migrate Tools requirements — as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/content_workflow_bynder -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_workflow_bynder -y
```

## Migrating from GatherContent

If your site still runs the deprecated **GatherContent** module, this module is
its replacement and will migrate the existing configuration on install. The
supported switch‑over is:

1. Add and install this module with Composer (as above).
2. **Uninstall** GatherContent.
3. **Remove** GatherContent from Composer once it has been uninstalled on all
   environments.

Because there is **no upgrade path** between major versions of this module
itself, plan a fresh configuration rather than an in‑place upgrade if you are
coming from an older major version.

## Verify it worked

After enabling, open the module's admin area (you will need the **administer
content_workflow_bynder** permission). Before you can import anything you must
connect your Content Workflow account with API credentials — see
[Configuration](../configuration/index.md).
