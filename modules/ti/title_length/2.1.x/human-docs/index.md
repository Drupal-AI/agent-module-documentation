# Title length — manual setup guide

**Title length** (`title_length`) raises the maximum number of characters allowed
in an entity's title field above Drupal's built‑in limit of 255. If your editorial
team keeps bumping into "this field is too long" on long headlines, product names,
or legal document titles, this module widens the underlying database column so
longer titles are accepted.

It is best thought of as a small framework. The parent `title_length` module
supplies the machinery (a reusable service and a Drush command) but **changes
nothing on its own** — you also enable one of its submodules to apply the new
length to a specific entity type: **Node title length** (`node_title_length`) for
node titles, and **Taxonomy term title length** (`taxonomy_term_title_length`) for
term names.

The default new length is **500 characters**, but you can pick your own value with
a variable in `settings.php`. There is no admin screen and no permissions — the
length lives in the database schema and in a settings variable, and a Drush command
re‑applies it if you change your mind later. A safety check prevents shrinking the
limit below titles that already exist.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   right submodule (the parent alone does nothing).
2. [Configuration](configuration/index.md) — choosing a custom length in
   `settings.php` and re‑applying it with Drush.

## Where it lives in the admin menu

Title length has no admin page. You enable it (and its submodules) at **Extend**
(`/admin/modules`), set an optional length in `settings.php`, and use the
`drush title_length:update` command if you change the length later.

## How to use it

1. Install the module and enable the submodule for the entity type you care about —
   `node_title_length` for node titles, `taxonomy_term_title_length` for term
   names. Enabling the submodule immediately widens the relevant title column to the
   default 500 characters.
2. If you want a different limit, set it in `settings.php` **before** enabling the
   submodule, or set it afterward and re‑apply with Drush (see
   [Configuration](configuration/index.md)).
3. That is it — editors can now enter longer titles with no further UI changes.
