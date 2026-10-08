# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (enabled by default on most sites) — the audit report
  is a View.

There are no third-party Composer or PHP library requirements, and the base
module has no other module dependencies. Individual submodules require the module
for the subsystem they track (for example `admin_audit_trail_group` needs the
Group module).

## Install with Composer

From the project root:

```bash
composer require drupal/admin_audit_trail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/admin_audit_trail -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_audit_trail -y
```

## Enable the submodules you need

The base module records almost nothing by itself — logging comes from the
submodules. Enable one for each subsystem you want to track:

```bash
drush en admin_audit_trail_node admin_audit_trail_user -y
```

The 16 available submodules:

| Submodule | Logs |
|-----------|------|
| `admin_audit_trail_node` | Node (content) create/update/delete and translations |
| `admin_audit_trail_user` | User account create/update/delete |
| `admin_audit_trail_user_roles` | User role assignment and removal |
| `admin_audit_trail_auth` | Authentication events (login, logout, password request) |
| `admin_audit_trail_taxonomy` | Vocabulary and term create/update/delete |
| `admin_audit_trail_menu` | Menu and menu-link changes, including translations |
| `admin_audit_trail_media` | Media asset create/update/delete |
| `admin_audit_trail_file` | Managed file create/update/delete |
| `admin_audit_trail_comment` | Comment create/update/delete |
| `admin_audit_trail_config` | Configuration changes (via a config event subscriber) |
| `admin_audit_trail_workflows` | Content Moderation / Workflows state transitions |
| `admin_audit_trail_group` | Group entity create/update/delete |
| `admin_audit_trail_paragraphs` | Paragraph entity create/update/delete |
| `admin_audit_trail_redirect` | Redirect entity create/update/delete (incl. i18n) |
| `admin_audit_trail_entityqueue` | Entityqueue subqueue create/update/delete |
| `admin_audit_trail_block_content` | Custom block content create/update/delete |

## Verify it worked

Grant the **Access admin audit trail** permission to your role, make a change
through the admin UI in a tracked subsystem (for example edit a node if you
enabled `admin_audit_trail_node`), then open **Reports → Audit trail**
(`/admin/reports/audit-trail`). The action should appear as a new row. See
[Configuration](../configuration/index.md) for the settings and permissions.
