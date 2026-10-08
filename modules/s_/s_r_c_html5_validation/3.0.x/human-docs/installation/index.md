# Installation

## Requirements

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`; the module's
  own notes indicate it also targets Drupal 12).

There are no dependent modules, no submodules, and no third-party PHP or JavaScript
library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/s_r_c_html5_validation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/s_r_c_html5_validation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en s_r_c_html5_validation -y
```

That is the whole setup. There is no configuration step — required select, radio
and checkbox fields begin enforcing native HTML5 validation immediately.

## Verify it worked

Open any form on your site that has a required select list, radio group or
checkbox, leave it unset, and try to submit. The browser should now stop the
submission and show its native "please choose" prompt for that field.
