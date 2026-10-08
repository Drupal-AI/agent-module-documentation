# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No third-party Composer libraries are required by the base module. The **TSA**
  submodule adds trusted timestamping and expects a timestamping authority to be
  available if you use it.

> The current release is an alpha (**1.0.0-alpha6**) — test it on a non-production
> environment before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/audit_trail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/audit_trail -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en audit_trail -y
```

## Enable the submodules you need

Audit Trail ships several optional submodules; enable only the ones that match
what you want to audit:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| Entity | `audit_trail_entity` | Audits entity create/update/delete. |
| Entity paragraphs | `audit_trail_entity_paragraphs` | Extends entity auditing to Paragraphs. |
| File | `audit_trail_file` | Audits file operations. |
| TSA | `audit_trail_tsa` | Adds trusted (RFC-style) timestamping to entries. |
| User auth | `audit_trail_user_auth` | Audits user authentication events. |

For example:

```bash
drush en audit_trail_entity audit_trail_user_auth -y
```

After enabling, set the HMAC key and grant the permissions before relying on the
trail — see [Configuration](../configuration/index.md).
