# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **[Webform](https://www.drupal.org/project/webform)** module (`webform`) —
  the project targets Webform 6.3.
- The **[Group](https://www.drupal.org/project/group)** module (`group`), version
  **3.x** (targets Group 3.2+). This release is built specifically for Group 3.x.

Both are enabled automatically as dependencies. Note this release is a beta
(1.0.0‑beta3) and is not covered by Drupal's security advisory policy — review it
before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/group_webform -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Webform and Group
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/group_webform -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en group_webform -y
```

## Verify it worked

On a group type, open its **Set available content** (relationship plugins) screen
and confirm you can install a **Group webform** relation for one of your webforms.
Install it, grant a group role the submission permissions, then check that a member
can submit that webform within their group and that submissions are scoped to the
group.
