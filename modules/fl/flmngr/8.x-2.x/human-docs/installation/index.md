# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 | ^11`).
- The **N1ED** module (`n1ed`) — a dependency, installed automatically by the
  Composer command below.
- **CKEditor 4 or CKEditor 5** as your text-format editor.
- Access to an **Flmngr backend** — either Flmngr's hosted service or a separately
  installed Flmngr server component — which is where uploads are actually handled.

> **Drupal 10.2 notice:** update Flmngr and *all* its dependencies to their latest
> versions, otherwise file browsing will not work.

## Install with Composer

From the project root:

```bash
composer require drupal/flmngr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the `n1ed`
dependency and any shared libraries alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flmngr -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flmngr -y
```

## Verify it worked

Flmngr automatically attaches to file-choose fields once enabled. To confirm the
CKEditor integration, open a text format that uses CKEditor (see
[Configuration](../configuration/index.md)) and check that the Flmngr buttons can
be added to the toolbar. Editing content with that format should then show the
Flmngr file-manager buttons.
