# Installation

## Requirements

- **Drupal 10.2 or newer, or Drupal 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Group** module (`group`) — this module provides a context for it.
- Optionally the **Group Sites** module, if you want the micro‑site access
  behaviour that pairs well with path‑prefix contexts.

## Install with Composer

From the project root:

```bash
composer require drupal/group_context_path_prefix -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/group_context_path_prefix -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_context_path_prefix -y
```

Drupal enables the Group dependency automatically if it isn't already on.

## Verify it worked

Assign a path prefix (for example `/private`) to a group, then place a piece of
content in that group. Its URL should be rewritten to sit under the prefix (for
example `/private/my-first-post`), and group‑aware features should resolve the
active group from the path.
