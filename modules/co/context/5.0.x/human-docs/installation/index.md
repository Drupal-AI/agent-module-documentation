# Installation

## Requirements

Context needs:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other contrib modules — Context declares no additional module dependencies.

This is a **release candidate** (5.0.0‑rc2), so test it before relying on it in
production. There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/context -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/context -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en context -y
```

## Enable the admin UI submodule

The base `context` module provides only the entity, plugins, and services — **it
has no interface for building contexts**. To get the admin UI, also enable the
bundled **Context UI** submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Context UI** | `context_ui` | The admin interface for creating and editing contexts at *Structure → Context* (`/admin/structure/context`). This is what you use to build contexts by clicking. |

```bash
drush en context_ui -y
```

Enabling `context_ui` also enables the base `context` module if it is not already
on. If you deploy contexts purely as exported configuration, you can leave
`context_ui` off in production and only enable it where you author contexts.

## Verify it worked

With `context_ui` enabled, go to **Structure → Context**
(`/admin/structure/context`). You should see the context listing page where you
can add a new context.
