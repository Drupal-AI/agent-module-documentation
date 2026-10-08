# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core **Toolbar** (`toolbar`) module — the inspector lives in the admin toolbar.
- The contrib **Context** (`context`) module — this tool inspects Context's active
  contexts, so Context must be installed and configured.
- No third‑party Composer packages or external libraries of its own.
- **Recommended (optional):** Gin, Gin Toolbar, and Admin Toolbar Language
  Switcher for a nicer admin experience.

## Install with Composer

From the project root:

```bash
composer require drupal/context_active_inspector -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including the Context requirement — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/context_active_inspector -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Context (if it is not already) and this module together:

```bash
drush en context context_active_inspector -y
```

## Grant the inspector permission

The module ships one permission, **access context active inspector**. At **People
→ Permissions** (`/admin/people/permissions`), grant it to the admin or developer
roles who should be able to use the inspector.

## Verify it worked

Log in as a user with the **access context active inspector** permission and load
any front‑end page. The admin **toolbar** should show the inspector item; open it
and you should see the contexts active on the current page. If you have no
contexts defined yet, create one in the Context UI and revisit — it should appear
in the inspector when its conditions match.
