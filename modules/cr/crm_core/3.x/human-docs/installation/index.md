# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No hard dependencies on other contributed modules, and no third‑party PHP
  libraries are required. Individual submodules integrate with modules such as Views
  when you enable them.

Note that this 3.x branch is **mostly not maintained** (the project is seeking a new
maintainer). For new Drupal 11 projects, consider the newer
[CRM](https://www.drupal.org/project/crm) module instead.

## Install with Composer

From the project root:

```bash
composer require drupal/crm_core -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crm_core -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base framework first:

```bash
drush en crm_core -y
```

## Submodules — enable only what you need

CRM Core's functionality is delivered through submodules. Enable them individually
with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Contact** | `crm_core_contact` | Contact entities and contact-type management — the foundation most sites start with. |
| **Activity** | `crm_core_activity` | Activity tracking, for logging interactions with a contact. |
| **Match** | `crm_core_match` | Duplicate detection / deduplication support when creating or importing contacts. |
| **User Sync** | `crm_core_user_sync` | Pairs Drupal user accounts with CRM contacts, keeping the two in step. |
| **Demo** | `crm_core_demo` | Sample demo content to explore the module — for evaluation, not production. |

For example, to enable contact management:

```bash
drush en crm_core_contact -y
```

## Verify it worked

After enabling `crm_core` and at least `crm_core_contact`, look for the CRM Core
contact administration pages in the admin menu. If the contact listing and
contact-type pages are present, the module is installed and ready to configure — see
[Configuration](../configuration/index.md).
