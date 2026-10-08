# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module — needed only for the auto‑trim path (trimming text by a
  character limit). If you always use an explicit separator you can do without it,
  but Views ships with Drupal core, so it's usually already available.

There are no third‑party Composer or PHP library requirements.

> **Release status:** the current release is a beta (8.x‑1.0‑beta3). Test before
> relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/expand_link_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/expand_link_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en expand_link_formatter -y
```

## Verify it worked

Go to a content type's **Manage display** (for example **Structure → Content types
→ Article → Manage display**) and open the **Format** dropdown for a long‑text
field such as **Body**. You should see **Expand link formatter** as an option.
Select it, save, then view a node whose body contains the separator (or is longer
than your character limit) — you should see a truncated excerpt with a "Read more"
link that expands the rest. See the "How to use it" section of the
[overview](../index.md) for the full walk‑through.
