# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **Workbench** (`workbench`) and **Workbench Access** (`workbench_access`)
  modules — installing this module pulls them in and enables them automatically.
- A **LocalGov Drupal** site is the intended context: the module adds its
  access‑control field to LocalGov content types (Subsite Overview, Subsite Page,
  Service Landing Page, Service Page).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_content_access_control -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch Workbench and
Workbench Access and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_content_access_control -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_content_access_control -y
```

Enabling it also enables Workbench and Workbench Access, and installs the "Access
Control" vocabulary, the access‑control field, the `site_section` scheme, and the
"Devolved Editor" role.

## Verify it worked

Check that the pieces were installed:

- **Structure → Taxonomy** shows an **Access Control** vocabulary.
- **Configuration → Workflow → Workbench Access**
  (`/admin/config/workflow/workbench_access`) shows a **Site Section** scheme.
- **People → Roles** includes a **Devolved Editor** role.

Then continue with [Configuration](../configuration/index.md) to build your
sections and assign editors.
