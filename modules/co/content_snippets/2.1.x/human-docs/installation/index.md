# Installation

## Requirements

Content Snippets is deliberately lightweight:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No third‑party Composer packages, PHP libraries, or contrib module
  dependencies — it relies only on Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/content_snippets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/content_snippets -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_snippets -y
```

## Set the permissions

The module ships two permissions, and the split between them is the whole point.
At **People → Permissions** (`/admin/people/permissions`):

- **Administer content snippets** — controls *which* snippets exist. A
  structural decision; grant it to site builders/administrators.
- **Edit content snippets** — controls *what* snippets say. An editorial
  decision; grant it to content editors.

## Verify it worked

Log in as a user with **Administer content snippets**, create a first snippet,
then confirm a user with only **Edit content snippets** can change its text but
not add or remove snippets. Because snippets are stored as configuration, a new
snippet will also appear in a `drush config:export` diff — a quick way to
confirm the module is storing data where you expect.
