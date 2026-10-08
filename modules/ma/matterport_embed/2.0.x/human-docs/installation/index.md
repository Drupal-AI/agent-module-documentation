# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- A **Matterport showcase** you want to embed — you'll need its share reference/URL
  when you add content.

There are no third‑party Composer or PHP library requirements. Note this is a
**minimally maintained**, **alpha** release and is **not covered by Drupal's
security advisory policy** — weigh that before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/matterport_embed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/matterport_embed -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en matterport_embed -y
```

The module declares its package as **Custom**, so it appears under that heading on
the Extend page (`/admin/modules`).

## Verify it worked

Add a **Matterport Embed** field to a content type under **Structure → Content types
→ *(type)* → Manage fields**. If the field type is available and you can configure
the **Matterport Embed Formatter** on the type's **Manage display**, the module is
installed correctly. See [Configuration](../configuration/index.md) for the field,
style, and option‑set details.
