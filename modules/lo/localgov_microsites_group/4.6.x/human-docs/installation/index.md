# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- A substantial stack of contrib modules, which Composer pulls in as dependencies.
  These include:
  - **Group** (`group`) and **Group Nodes** (`gnode`) — the multi-tenant foundation.
  - **Domain** (`domain`) and **Domain Path** (`domain_path`) — per-microsite domains.
  - **Group Sites** (`group_sites`), **Group Context Domain**
    (`group_context_domain`), **Group Content Menu** (`group_content_menu`),
    **Group Media** (`groupmedia`), **Group Invite** (`ginvite`).
  - **Field Group** (`field_group`), **Replicate** (`replicate`), **Role Delegation**
    (`role_delegation`), **Override Node Options** (`override_node_options`).
  - **LocalGov Page** (`localgov_page`) and **LocalGov Search** (`localgov_search`).

Because of the size of this stack, this module is best treated as part of the LocalGov
Microsites distribution rather than a standalone install.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_microsites_group -W
```

The `-W` (`--with-all-dependencies`) flag is important here — it lets Composer install
and update the whole dependency stack consistently.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_microsites_group -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_microsites_group -y
```

Enabling the module turns on its dependency stack as well.

## Submodules — enable only what you need

The module ships several optional submodules that add per-microsite content types and
features. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Blogs** | `localgov_microsites_blogs` | Blog content per microsite. |
| **Directories** | `localgov_microsites_directories` | Directory content per microsite. |
| **Events** | `localgov_microsites_events` | Events content per microsite. |
| **Group Term UI** | `localgov_microsites_group_term_ui` | A taxonomy-term management UI per microsite. |
| **Group Webform** | `localgov_microsites_group_webform` | Per-microsite webforms. |
| **Guides** | `localgov_microsites_guides` | Guide content per microsite. |
| **News** | `localgov_microsites_news` | News content per microsite. |
| **Publications** | `localgov_microsites_publications` | Publication content per microsite. |
| **Step by Step** | `localgov_microsites_step_by_step` | Step-by-step content per microsite. |

For example, to add per-microsite news:

```bash
drush en localgov_microsites_news -y
```

There is also a `localgov_microsites_permissions` submodule that extends group
permissions so microsite administrators can manage their own group's permissions.

## Verify it worked

Go to `/admin/microsites/add/{group_type}` and confirm you can start creating a
microsite, and check that the LocalGov microsite permissions appear under **People →
Permissions**. Then continue to [Configuration](../configuration/index.md) to create
and set up your first microsite.
