# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- A **traditional, theme‑based** Drupal front end. This module is not for decoupled
  front ends or SPAs — for those, include the NYSDS library directly in your
  project instead.

There are **no additional module or library dependencies** — the NYS Design System
library is included, fully built, at a specific version inside the module itself.

## Install with Composer

This project is **versioned to match a specific NYSDS release**. Install the version
of the module that corresponds to the NYSDS version you need, and **avoid `^` or
`~`** in your constraint so upgrades remain deliberate and reviewable. For example,
pin an exact version:

```bash
composer require drupal/nys_ds:1.19.0 -W
```

Replace `1.19.0` with the release that matches your required NYSDS version.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/nys_ds:1.19.0 -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nys_ds -y
```

After enabling, add this module as a **dependency of any theme or module** that
will use NYSDS components — recommended for clarity and dependency management, even
though Drupal registers the components without it.

## Verify it worked

In a Twig template, `include` an NYSDS component (for example `nys_ds:alert`) with
its expected properties, clear caches (`drush cr`), and confirm the component
renders with NYSDS styling on the page.
