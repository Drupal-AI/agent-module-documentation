# Installation

## Requirements

- **Drupal 9, 10 or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **File** (`file`) module, which Drupal enables automatically.
- **HTTPS** in every environment where recording happens — the browser media APIs
  the widget relies on will not run on an insecure origin.
- The Webform submodule additionally needs the contrib **Webform** module.

## Install with Composer

From the project root:

```bash
composer require drupal/audiorecorder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/audiorecorder -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix. DDEV serves the site over
> HTTPS by default, which the recorder needs.

## Enable the module

```bash
drush en audiorecorder -y
```

## Submodule — Webform integration

**Audio Recorder Webform Integration** (`audiorecorder_webform_integration`) adds
the recorder to Webform. Enable it only if you collect audio through Webform:

```bash
drush en audiorecorder_webform_integration -y
```

Then set the recorder as a file field's widget on **Manage form display**. See
[How to use it](../index.md#how-to-use-it).
