# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **TMGMT** (`drupal/tmgmt`, `^1.5`) and **TMGMT File** (`tmgmt_file`) — both
  required.
- The PHP **zlib** extension (`ext-zlib`) — used to gzip the XLIFF payloads. The
  module reports itself unavailable if zlib is missing.
- Access to a **memoQ server's CMS API** — you'll need its gateway URL and an API
  key.

## Install with Composer

From the project root:

```bash
composer require drupal/tmgmt_memoq -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in TMGMT and its
dependencies and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tmgmt_memoq -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tmgmt_memoq -y
```

This also enables TMGMT and TMGMT File if they aren't on already. There are no
submodules.

## Next step

The module adds no menu item of its own. Go to **Translation → Providers**
(`admin/tmgmt/translators`) and create a new translator of type **MemoQ**, then
enter your CMS API URL and key — see [Configuration](../configuration/index.md).
