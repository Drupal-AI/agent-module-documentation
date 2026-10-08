# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No required contrib dependencies and no third‑party PHP or JavaScript
  libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/content_feedback -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_feedback -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_feedback -y
```

## Verify it worked

After enabling, open the module's settings form (via the **Configure** link on the
**Extend** page, `/admin/modules`) and select at least one content type. Grant the
feedback‑form permission to a role, then view a page of that content type as a user
in that role — you should see the feedback form. See
[Configuration](../configuration/index.md) for the details, including how to review
submitted feedback and mark items resolved.
