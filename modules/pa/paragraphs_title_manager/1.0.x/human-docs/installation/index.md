# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- The **Paragraphs** module (`paragraphs`) — a hard dependency, enabled
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_title_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs and
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/paragraphs_title_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_title_manager -y
```

Drupal will enable Paragraphs automatically if it is not already on.

## Grant the permission

The configuration screen is protected by a single permission, **Manage Paragraphs
Title Alignment**. Go to **People → Permissions**
(`/admin/people/permissions`), grant that permission to the administrator roles
who should manage alignment, and save. Users without it cannot open or change the
settings.

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`), then, as a user
with the permission above, open **Configuration → Content authoring → Paragraph
Title Settings** (`/admin/config/content/paragraph-title-settings`). You should
see your Paragraph bundles and their detected title fields listed. See
[Configuration](../configuration/index.md) for how to use the form.
