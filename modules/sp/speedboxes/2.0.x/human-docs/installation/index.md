# Installation

## Requirements

- **Drupal 11.2 or newer, or Drupal 12** (`core_version_requirement: ^11.2 || ^12`).
- No other module dependencies, and no additional PHP or library requirements.
- The [Group](https://www.drupal.org/project/group) module is optional — if it is
  installed, Speedboxes also enhances its group-permissions form.

## Install with Composer

From the project root:

```bash
composer require drupal/speedboxes
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/speedboxes`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en speedboxes -y
```

That is all it takes — the drag-to-toggle behaviour is active immediately on the
Permissions form. There is no configuration.

## Verify it worked

Go to **People → Permissions** (`/admin/people/permissions`). Left-click and drag
the mouse across a run of checkboxes; a small toolbar should appear letting you
check, uncheck or invert the selection. Save the form to apply the change.
