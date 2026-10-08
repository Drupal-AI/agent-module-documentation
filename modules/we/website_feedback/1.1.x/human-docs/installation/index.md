# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Text** (`text`) and **Image** (`image`) modules — Drupal enables these
  automatically as dependencies when you turn on Website Feedback.
- No third‑party Composer or PHP library requirements. Screenshots use the
  **html2canvas** JavaScript library, which loads from the jsDelivr CDN out of the
  box; you only need a local copy if you turn the CDN option off (see
  [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/website_feedback -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/website_feedback -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en website_feedback -y
```

## Grant the permission that shows the button

This is the important step: the floating **Feedback** button only appears for
users who have the **create website feedback** permission. Go to **People →
Permissions** (`/admin/people/permissions`) and grant that permission to the roles
that should be able to submit feedback. Nothing shows on the site until you do
this.

The module ships five permissions in total (administer, create, view, edit, and
delete website feedback) — see [Configuration](../configuration/index.md) for what
each one gates.

There are no submodules.
