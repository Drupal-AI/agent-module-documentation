# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The [**Mercury Editor**](https://www.drupal.org/project/mercury_editor) module —
  the page‑building experience this integrates with.
- The [**Content Lock**](https://www.drupal.org/project/content_lock) module — which
  provides the actual locking behaviour.

This module only supplies the UI glue between the two; both must be installed and
enabled for it to do anything. There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mercury_editor_content_lock -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If you do not already have Mercury Editor and Content Lock
installed, require them too:

```bash
composer require drupal/mercury_editor drupal/content_lock -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mercury_editor_content_lock -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mercury_editor_content_lock -y
```

Make sure Mercury Editor and Content Lock are enabled and configured as normal —
enable Content Lock for the content types you want locked, and grant the appropriate
lock and break‑lock permissions.

## Verify it worked

With locking enabled for a content type, open a piece of that content in Mercury
Editor as one user, then try to edit the same content as a second user. The second
user should see Mercury Editor's interface disabled with a modal explaining the
content is locked (and an unlock option if they can break locks). The first user
should see an **unlock** button to release the lock.
