# Installation

## Requirements

- **Drupal 11.2+ or 12** (`core_version_requirement: ^11.2 || ^12`).
- The **Canvas** module (`canvas`) — required; it provides the visual editor the components
  plug into. Enabled automatically as a dependency.
- A **Bootstrap 5 theme** so the components render correctly in the Canvas preview and on the
  front end. The maintainers recommend **Bootstrap Forge**, a Canvas‑first Bootstrap 5
  starter theme.
- No additional third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/canvas_bootstrap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed, including the Canvas module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/canvas_bootstrap -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en canvas_bootstrap -y
```

That is the entire setup. The components become available in Canvas immediately — there is no
configuration to do, no content types to create, and no admin pages to visit.

## Verify it worked

Open a page or block in the **Canvas** editor and look for the **Canvas Bootstrap** component
group. You should be able to drag components such as Button, Card, Row, and Accordion onto
the canvas and edit their properties. If they appear but look unstyled, confirm your active
theme is a Bootstrap 5 theme.
