# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8** or newer.

There are no other module dependencies and no third‑party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/expose_status -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/expose_status -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en expose_status -y
```

Enabling the module generates the per-site token and activates the JSON endpoint.

## Submodules — enable only what you need

Expose Status Report ships several optional submodules. Enable them individually
with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Details** | `expose_status_details` | Includes the full requirement details in the JSON response. Enable only when you need them — details can be sensitive. |
| **Ignore** | `expose_status_ignore` | Lets you skip named checks with a `?ignore=…` query parameter, and invert the list with `?ignore_negate=1`. |
| **Severity** | `expose_status_severity` | Adds `?only_above_level=1` so the endpoint fails on errors only, not warnings. |

For example:

```bash
drush en expose_status_ignore -y
```

## Verify it worked

Retrieve your endpoint and token:

```bash
drush ev "expose_status_instructions()"
```

Open the printed `/admin/reports/status/expose/{token}` URL — you should get JSON
with a `status` field. Then confirm the protection works: request the same path
with a wrong or missing token and you should receive a **403**.

Next, see the "How to use it" section of the [overview](../index.md) for wiring the
endpoint into a monitoring system.
