# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- A standard Drupal node system. To make the per‑language permissions meaningful you
  will typically also have core's **Language** (and usually **Content Translation**)
  configured with more than one language.

There are no third‑party Composer or PHP library requirements, and no additional
contributed‑module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/node_view_language_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_view_language_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_view_language_permissions -y
```

## After enabling — grant permissions and rebuild

Because this module uses Drupal's node‑grants system, two follow‑up steps are needed
(see the [overview](../index.md) for detail):

1. Grant the per‑type, per‑language **View own/any content** permissions at
   **People → Permissions** (`/admin/people/permissions`).
2. **Rebuild node access permissions** at **Reports → Node access permissions** so the
   grants take effect.

## Verify it worked

Open **People → Permissions** and confirm the **Node view language permissions**
section lists a "View own content" and "View any content" permission for each content
type and language. After granting them and rebuilding, log in as a test user and check
that nodes in a language they lack permission for do not appear in listings, search, or
the node itself.
