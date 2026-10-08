# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The core **Content** view must be enabled — this is the default content overview
  view, present and enabled on a standard Drupal install. Content filter embeds it
  to build each per‑type page.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_filter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_filter -y
```

Enabling the module changes nothing on its own — no pages are created until you
select content types on the settings form.

## Verify it worked

Go to **Configuration → User interface → Content filter**
(`/admin/config/user-interface/content-filter`) and confirm the settings form
loads. Select a content type, save, and then open
`/admin/content/filtered/{that_type}` — you should see the core content listing
scoped to just that type, with an **Add {bundle}** button. See
[Configuration](../configuration/index.md) for the details.
