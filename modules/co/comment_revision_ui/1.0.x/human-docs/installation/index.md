# Installation

## Requirements

- **Drupal 9.1 or 10** (`core_version_requirement: ^9.1 || ^10`).
- Core's **Comment** module (`comment:comment`) enabled.
- **Core patches** (see below) — this module builds on in‑progress core work, so
  the patches are a hard prerequisite, not optional.

There are no third‑party Composer or PHP library requirements.

## Apply the required core patches

This module depends on two core patches. Apply them to your project before (or
alongside) installing the module — a common approach is to add them to your
project's `composer.json` under `extra.patches` using
[`cweagans/composer-patches`](https://www.drupal.org/docs/develop/using-composer/manage-dependencies#patches):

1. **Make comment entities revisionable** — the work from Drupal core issue
   **#2880154**.
2. **Generic revision UI** — the work from Drupal core issue **#2350939**, which
   provides the shared revision interface this module reuses.

After applying the patches, run database updates so the comment entity type becomes
revisionable:

```bash
drush updb -y
```

## Install with Composer

From the project root:

```bash
composer require drupal/comment_revision_ui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/comment_revision_ui -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en comment_revision_ui -y
```

## Assign permissions

Go to **People → Permissions** (`/admin/people/permissions`) and look for the
**Comment Revision UI** section. Grant permissions to the appropriate roles:

- **View** revision permissions (for example `view any comment revisions`, or the
  per‑comment‑type equivalents) — safe to give auditors read‑only history access.
- **Revert** and **delete** revision permissions — these are content mutations, so
  grant them sparingly and only to trusted moderators.

Per‑comment‑type permissions let you scope access to specific comment bundles for
finer control. Export any configuration changes if your workflow tracks config.

## Verify it worked

Edit an existing comment (to create a second revision), then open that comment's
**Revisions** / version‑history tab. You should see the revision list with the
options your permissions allow — view, revert, or delete — rendered in the admin
theme.
