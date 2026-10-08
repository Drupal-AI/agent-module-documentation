# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- Core **Node** (`node`), **Taxonomy** (`taxonomy`), and **Views** (`views`) —
  Drupal enables these automatically as dependencies (they are on by default on a
  standard site).
- No third‑party PHP libraries are required.

> **Note:** this project is marked **Obsolete** and is **not** covered by Drupal's
> security advisory policy. Treat it as a starting point you will maintain
> yourself.

## Install with Composer

From the project root:

```bash
composer require drupal/library_books -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/library_books -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en library_books -y
```

Enabling the module installs its configuration — the content type, fields,
taxonomy, and Views — and creates the `library_book_issue_log` table. There are no
submodules.

## Verify it worked

1. Confirm **Library Books** is enabled on **Extend** (`/admin/modules`).
2. Under **Structure → Content types** (`/admin/structure/types`), confirm the
   **Library Books** type exists, and under **Structure → Taxonomy** confirm the
   department vocabulary is present.
3. Create a test Library Books node, mark it issued, and view it — you should see
   an "Issued N times" count on the page.

There is no configuration step. See the module's [main page](../index.md) for how
the content model and issue log work.
