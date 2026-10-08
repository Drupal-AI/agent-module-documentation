# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Serialization** module (`serialization`) — enabled automatically as a
  dependency.
- The **crosswalk CLI binary**, installed on your web server and available on its
  PATH. This is an external command-line tool, not a Composer package, and Crosswalk
  cannot convert anything without it.
- **RDF mappings** for the content you want to render, *or* a manually created
  crosswalk profile for your content type(s).

## Install with Composer

From the project root:

```bash
composer require drupal/crosswalk -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crosswalk -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix. Note that the crosswalk CLI
> binary must be present *inside* whatever environment actually serves the site — in
> DDEV that means inside the web container.

## Enable the module

```bash
drush en crosswalk -y
```

Core Serialization will be enabled alongside it if it isn't already.

## Verify it worked

Confirm the module is enabled (`drush pm:list --status=enabled | grep crosswalk`)
and that the crosswalk CLI binary is reachable from the web server. Then set up your
RDF mappings or a crosswalk profile and check that a scholarly node renders the
expected schema.org JSON-LD or citation output — see "How to use it" in the
[overview](../index.md).
