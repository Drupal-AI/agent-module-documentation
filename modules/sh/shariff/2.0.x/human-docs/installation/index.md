# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- **PHP 7.0 or newer**.
- The **external Shariff JavaScript library** from heise online, version 1.4.6
  or newer, placed under `/libraries/shariff/`. This is not a Composer package —
  see the step below.
- No other Drupal modules are required. **Metatag** is an optional suggestion:
  if it is enabled, the node-view buttons use its title token for the share
  title.

## Install with Composer

From the project root:

```bash
composer require drupal/shariff -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/shariff -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Add the Shariff JavaScript library

The module wraps a third-party widget, so you must download that widget
separately and unpack it so that a file such as
`/libraries/shariff/shariff.min.js` resolves. The module's library handling also
supports `/build` and `/dist` subfolders. Until the library is in place,
Drupal's *Status report* (`/admin/reports/status`) shows an error from Shariff's
`hook_requirements`, and the buttons will not fully render.

## Enable the module

```bash
drush en shariff -y
```

There are no submodules. Once enabled — and once the library is present — you can
place the block and enable the node display field as described in
[Configuration](../configuration/index.md).

## Verify it worked

Visit **Configuration → Web services → Shariff**
(`/admin/config/services/shariff`); the settings form should load. Then place the
**Shariff share buttons** block or enable the field on a content type, and load a
page — you should see the share buttons render (once the JavaScript library is
installed).
