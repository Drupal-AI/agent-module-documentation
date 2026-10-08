# Installation

## Requirements

- **Drupal 8 or later** (`core_version_requirement: >=8`).
- The **Translation Management Tool** module (`tmgmt`) and its content source
  **TMGMT Content** (`tmgmt_content`) — these are hard dependencies and provide
  the job workflow this provider plugs into.
- A registered account on the **GearTranslations** platform and an **API access
  token**. Contact drupal@geartranslations.com to get one.

There are no additional PHP or third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tmgmt_geartranslations -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in TMGMT and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tmgmt_geartranslations -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tmgmt_geartranslations -y
```

Drupal will enable `tmgmt` and `tmgmt_content` at the same time if they are not
already on.

## Verify it worked

Go to **Configuration → Regional and language → Translation providers**
(`/admin/tmgmt/translators`) and start adding a provider — **GearTranslations**
should now appear as a selectable translator plugin. From there, continue to
[Configuration](../configuration/index.md) to enter your access token.
