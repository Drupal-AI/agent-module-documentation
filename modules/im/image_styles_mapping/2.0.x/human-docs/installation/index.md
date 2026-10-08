# Installation

## Requirements

- **Drupal 11.3 or 12** (`core_version_requirement: ^11.3 || ^12`).
- Core's **Field UI** module (`field_ui`) — enabled automatically as a dependency.
- Core's **Views** module — optional; when present, the report gains a "views" tab
  that scans View displays. Without it, only the fields report shows.
- Users need the **access image styles mapping report** permission to view the
  report.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/image_styles_mapping -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_styles_mapping -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_styles_mapping -y
```

## Verify it worked

At **People → Permissions**, grant **access image styles mapping report** to a
role, then visit **Reports → Image Styles Mapping**
(`/admin/reports/image_styles_mapping_report`). You should see the usage report
with its fields (and, if Views is enabled, views) tabs. See the
[manual setup guide](../index.md) for how to read it.
