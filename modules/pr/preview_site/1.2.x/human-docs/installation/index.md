# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Several contributed modules that power generation and relationship tracking:
  - **Tome** (`tome_static`) — the default static‑site generator.
  - **Entity Usage** (`entity_usage`) — identifies related content that may also
    need drafts included in the preview.
  - **Dynamic Entity Reference** (`dynamic_entity_reference`) — lets a preview site
    hold varied content‑entity types.
- Core's **File** module (`file`).

Composer resolves these for you when you require the module with `-W`.

## Install with Composer

From the project root:

```bash
composer require drupal/preview_site -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Tome, Entity Usage,
Dynamic Entity Reference, and the other dependencies alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/preview_site -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en preview_site -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Preview Site S3** | `preview_site_s3` | A deployment strategy that pushes the generated static files to an Amazon S3 bucket. Enable it if S3 is your preview destination. |

Enable the S3 submodule when you need it:

```bash
drush en preview_site_s3 -y
```

If you do **not** enable the S3 submodule, you'll need another module that provides
a deployment‑strategy plugin — at present that means custom code.

## Verify it worked

After enabling, go to **Structure → Preview site → Strategies**
(`/admin/structure/preview-site/strategies`). You should be able to add a new
strategy and see the available generation and deployment plugins. Next, create a
build and deploy it — see [Configuration](../configuration/index.md).
