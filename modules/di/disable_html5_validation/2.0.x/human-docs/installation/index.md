# Installation

## Requirements

- **Drupal 9 or newer** (`core_version_requirement: >=9`).
- Nothing else — no module dependencies, no third-party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/disable_html5_validation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/disable_html5_validation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disable_html5_validation -y
```

That's the whole setup. From now on every form is rendered with the `novalidate`
attribute and the browser's native HTML5 validation is off site-wide. There is no
configuration screen and no submodules.

## Turning it off again

Because the module stores no configuration, uninstalling it cleanly restores default
HTML5 validation on every form with nothing left behind:

```bash
drush pmu disable_html5_validation -y
```
