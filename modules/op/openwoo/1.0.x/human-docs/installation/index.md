# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **OpenWoo core module has no dependencies** of its own.
- The **OpenWoo Publish** submodule requires core's **Media** and **Media Library**
  modules.
- An **API key** from [OpenWoo.app](https://openwoo.app/) if you want to publish
  data to (or speed up search against) that service — see
  [Configuration](../configuration/index.md).
- **Optional:** the [s3fs](https://www.drupal.org/project/s3fs) module if you plan
  to store publication attachments in an S3 bucket (used by the attachments
  feature).

## Install with Composer

From the project root:

```bash
composer require drupal/openwoo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/openwoo -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en openwoo -y
```

## Submodules — enable what you need

OpenWoo's functionality is split across two submodules; enable whichever you need:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **OpenWoo Search** | `openwoo_search` | A pluggable search provider plus a search block with year, category, and free-text filters. |
| **OpenWoo Publish** | `openwoo_publish` | A publication entity type (shown as a tab on the Content page) with create/edit/delete and publish toggle; pushes publications to the configured provider on cron. Requires Media and Media Library. |

For example, to enable both:

```bash
drush en openwoo_search openwoo_publish -y
```

## Set up permissions

Right after enabling, review the module's permissions at **People → Permissions**
(`/admin/people/permissions#module-openwoo`) and grant them deliberately to the
roles that should manage the organisation settings and publications.

## Verify it worked

Go to **Configuration → Web services → OpenWoo**
(`/admin/config/services/openwoo`) and confirm the organisation settings form
appears. Continue with [Configuration](../configuration/index.md) to fill in the
organisation, choose your client(s), add the API key, and (for Search) place the
search block.
