# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Text** module (`text`) — it ships with Drupal core and is enabled
  automatically as a dependency; the module scans the formatted‑text field types it
  provides.

There are no third‑party Composer or PHP library requirements.

> **Recommendation:** install and run this on a **development or staging** copy of
> your site rather than production. Depending on how much content you have, the
> results table can become large, so it's meant to be used for an audit and then
> uninstalled.

## Install with Composer

From the project root:

```bash
composer require drupal/html_tag_usage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/html_tag_usage -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en html_tag_usage -y
```

## Verify it worked

Log in as an administrator. You should find a configuration page at
**Configuration → Development → HTML Tag Usage**
(`/admin/config/development/html_tag_usage`) and a report at **Reports → HTML Tag
Usage** (`/admin/reports/html_tag_usage`). See [Configuration](../configuration/index.md)
for the scan‑and‑report workflow and the permissions to grant.

## Cleaning up after the audit

When you've finished, **uninstall** the module to drop its potentially large results
table:

```bash
drush pmu html_tag_usage -y
```
