# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A browser with camera access — capture happens client‑side in the visitor's
  browser.
- No third‑party Composer or PHP library requirements, and no other module
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/camera_capture -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/camera_capture -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en camera_capture -y
```

That's all the setup there is — there is no configuration form. The capture form is
available at `/camera-capture` to users with the **access content** permission;
configure that permission to match who should be able to capture media.
