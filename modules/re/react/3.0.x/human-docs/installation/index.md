# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Importmaps** module (`importmaps`), which this 3.x branch uses to register
  the React libraries. It is pulled in as a dependency with Composer.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/react -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies and bring in Importmaps if it is not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/react -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en react -y
```

The Importmaps module is enabled automatically as a dependency.

## Verify it worked

Because React does nothing on its own, the real test is from a consuming module:
depend on the `react` library, mark React/React-DOM as external in your bundler,
and confirm that `import React from 'react'` resolves in the browser (no console
errors, and your React component renders). See the [overview page](../index.md)
for the developer workflow.
