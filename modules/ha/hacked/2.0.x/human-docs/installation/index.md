# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Update** module (`update`) enabled — Hacked! uses it to learn which
  projects and versions are installed. Drupal enables it as a dependency if needed.
- Your server must be able to **download release archives** from drupal.org (Hacked!
  fetches the official copy of each project to compare against). If outbound
  requests are blocked, projects will come back as *Unchecked*.
- **Optional:** the **Diff** module (`drupal/diff`) if you want to view file-by-file
  diffs of what changed. Without it, you still get the changed/missing file counts.
- **Optional (CLI diff):** the system `diff` binary must be available to PHP for the
  `hacked:diff` Drush command to work.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/hacked -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To also get the diff view:

```bash
composer require drupal/hacked drupal/diff -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hacked -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hacked -y
```

(Add `diff` to that command if you installed it: `drush en hacked diff -y`.)

## First run

1. Go to **Reports → Hacked!** (`/admin/reports/hacked`). The first check downloads
   and hashes every project, so it can take a while — subsequent views are served
   from a cache (roughly a day) until you force a rebuild.
2. Review which projects show as **Changed** and investigate them.

See [Configuration](../configuration/index.md) for reading the report, the Drush
commands, and the one available setting.
