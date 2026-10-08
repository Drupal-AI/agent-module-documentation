# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** and **Comment** modules enabled.

There are no required third‑party dependencies. Two modules are *optionally*
supported if present: **Forum** (adds a paste link to paste comments as new forum
topics) and **Flatcomments** (limits paste links to entities only).

> **Note:** version 2.0.x is under active development (alpha) and aims for feature
> parity with the older Drupal 7 release. Test it on a non‑production environment
> before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/comment_mover -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/comment_mover -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en comment_mover -y
```

## Place the Clipboard block

Comment Mover is driven by a **Clipboard** block. Go to **Structure → Block
layout** (`/admin/structure/block`) and place the **Clipboard** block into a
region you'll see while browsing — the **Sidebar** is a common choice — then save
the layout.

## Set permissions

The cut/paste and convert actions require core's **`administer comments`**
permission. Grant it (at **People → Permissions**,
`/admin/people/permissions`) only to trusted users.

## Verify it worked

As a user with `administer comments`, browse to a node with comments. You should
see **cut** and **paste** links under nodes and comments, and the **Clipboard**
block wherever you placed it. Cut a comment, paste it under a different node, and
confirm it (and any replies) moved across.
