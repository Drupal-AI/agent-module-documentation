# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **File** module (`file`) enabled — the only hard dependency. Drupal enables
  it automatically as a dependency.

Recommended companion modules (each unlocks an optional feature):

- **Token** (`drupal/token`) — validates your patterns and gives you an inline
  token‑tree browser so you can see which tokens are available.
- **Pathauto** (`drupal/pathauto`) — enables the "clean up with Pathauto's alias
  cleaner" option on your path/filename patterns.
- **Redirect** (`drupal/redirect`) — enables the per‑field "Create Redirect" option so
  a moved file's old URL redirects to its new one.

## Install with Composer

From the project root:

```bash
composer require drupal/filefield_paths -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Because this is a release candidate, you may need Composer's
minimum‑stability settings to allow `rc` releases.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/filefield_paths -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filefield_paths -y
```

Once enabled, open any File or Image field's settings form and you'll find a new
*File (Field) Paths* section — see [Configuration](../configuration/index.md).

## Drush command

The module ships one Drush command, **`filefield_paths:update`** (alias **`ffpu`**),
which runs retroactive path/filename updates for chosen entity type / bundle / field
instances from the command line — handy for bulk‑reorganizing an existing site. Add
`--all` to update every file field on the site. Run `drush ffpu --help` for the exact
arguments.
