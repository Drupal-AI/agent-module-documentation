# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Media** module (`media`) — the widget works with media entity reference
  fields.
- The **IMCE** module (`imce`) — the widget opens IMCE for file selection, and
  IMCE must be configured for the file scheme (public or private) you plan to use.
- Core's **File** and **Image** modules are used as part of the media/file stack
  (present in a standard install).

There are no third‑party Composer requirements. jQuery UI, used for the modal
dialog, ships with Drupal core.

> **Note:** This project is **not covered by Drupal's security advisory policy**.
> Weigh that before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/imce_field_widget -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Media and IMCE if they are not already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/imce_field_widget -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en imce_field_widget -y
```

This also enables Media and IMCE if they are not already on.

## Verify it worked

Go to a content type's **Manage form display** (for example **Structure → Content
types → Article → Manage form display**) and confirm that **IMCE Field Widget**
now appears as a widget option for a single-value media field. Set it, choose the
file scheme, and edit content to confirm the **Select Media** button opens IMCE in
a modal. See "How to set it up" in the [overview](../index.md).

> **Only single-value media fields.** The widget works with media entity reference
> fields whose cardinality is 1. It will not apply to multi-value fields.
