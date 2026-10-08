# Installation

## Requirements

Paragraphs Admin needs:

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11.0`).
- **PHP 8.1 or newer**.
- The contrib **Paragraphs** module (`drupal/paragraphs` `^1`) — this is the whole
  point of the module, so it must be installed and enabled.
- Core's **User** and **Views** modules, which Drupal enables automatically as
  dependencies.

There are no third-party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_admin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in or update shared
dependencies (including Paragraphs) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/paragraphs_admin -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_admin -y
```

Enabling it installs the `paragraphs` View and wires up the Host Entity field and
the paragraph delete form. There is no configuration step.

## Grant the permission

The paragraph overview is gated by the **Administer paragraphs** permission, which
is marked *restrict access* (it lets a user see and delete any paragraph on the
site). Grant it to trusted administrator roles only:

```bash
drush role:perm:add editor 'administer paragraphs'
```

Or grant it through the UI at **People → Permissions**
(`/admin/people/permissions`).

## Verify it worked

Log in as a user who has the permission and visit **Content → Paragraphs**
(`/admin/content/paragraphs`). You should see a table listing your paragraph
entities, each with a **Host Entity** link. This module has no other setup — it
works as soon as it is enabled and the permission is granted.
