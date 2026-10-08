# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Node** module (`node`) — Drupal enables it as a dependency automatically.
- No third‑party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/previewer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/previewer -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en previewer -y
```

That's all — there is no configuration.

## Verify it worked

Edit any node and click the **Preview** button. Instead of loading a separate
preview page, an off‑canvas dialog should open showing the rendered node. Change a
field while the dialog is open and confirm the preview refreshes to match.
