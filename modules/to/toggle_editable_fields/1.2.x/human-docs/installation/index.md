# Installation

## Requirements

- **Drupal 9.5, 10.2, or 11** (`core_version_requirement: ^9.5 || ^10.2 || ^11.0`).
- Core's **Field** (`field`) and **Field UI** (`field_ui`) modules.
- The contrib **Libraries** module (`drupal/libraries`, version `^4.0`) — required
  and pulled in by Composer.
- The external **Bootstrap Toggle** JavaScript/CSS library, placed under
  `/libraries` (see below). This is what actually draws the switch.

## Install with Composer

From the project root:

```bash
composer require drupal/toggle_editable_fields -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also pulls in the required **Libraries** module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/toggle_editable_fields -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Add the Bootstrap Toggle library

The module needs the Bootstrap Toggle library's files on disk. Download it from
<https://github.com/minhur/bootstrap-toggle/> and place it so that the file
`bootstrap-toggle.min.js` resolves at:

```
/libraries/bootstrap-toggle/js/bootstrap-toggle.min.js
```

(with the matching CSS alongside it). If the library is missing, the module's
status report shows a **warning** — the module still enables, but the switch won't
render correctly until the files are present.

## Enable the module

```bash
drush en toggle_editable_fields -y
```

This enables the Libraries, Field, and Field UI dependencies if they aren't already
on. There is no settings form — apply the **Toggle Editable Formatter** per field
on a display, as described in the [overview](../index.md#how-to-use-it).

There are no submodules.
