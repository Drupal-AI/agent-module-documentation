# Installation

## Requirements

Sub-pathauto is lightweight and has no third-party libraries. It needs:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Path alias** module (`path_alias`), which Drupal enables automatically
  as a dependency.

The [Redirect](https://www.drupal.org/project/redirect) module is **optional** —
it is only needed if you want the "Support for redirects" setting (see
[Configuration](../configuration/index.md)). Without it, everything else still
works; that one checkbox is simply disabled.

## Install with Composer

From the project root:

```bash
composer require drupal/subpathauto -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/subpathauto -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en subpathauto -y
```

That's all it takes. Sub-path resolution is active immediately for every alias on
the site — no per-page configuration. To confirm it worked, alias a node (for
example `/node/1` → `/about-us`) and then visit `/about-us/edit`; you should land
on that node's edit form.

There are no submodules.

If you want to tune the search depth or enable redirect support, see
[Configuration](../configuration/index.md).
