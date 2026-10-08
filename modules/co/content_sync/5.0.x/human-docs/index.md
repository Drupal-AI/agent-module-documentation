# Content Sync — manual setup guide

**Content Sync** (`content_sync`) does for your *content* what Drupal's core
configuration management does for *config*: it exports content entities (nodes,
taxonomy terms, menus, blocks, paragraphs, users, path aliases, and more) to
human-readable YAML files, diffs those files against the running site, and imports
them again on another environment. That lets you move editorial content from staging
to production, ship seed/demo content inside a deployment, keep a content snapshot in
git for code review, or reproduce a bug by exporting a single node.

Instead of inventing its own format, it reuses Drupal's serialization stack. Each
entity becomes one YAML file, and references between entities are stored by **UUID**
rather than by numeric ID — so the same content lands correctly on a different site
where the numeric IDs differ. Files can travel with the content (inlined as base64 or
copied alongside the YAML), and an import matches entities by UUID: an existing one is
updated in place, an unknown one is created, with referenced entities imported first.

You drive it from an admin UI under **Configuration → Development → Content** or from
`drush content-sync:export` / `content-sync:import` for automated deployments. A
plugin type (`sync_normalizer_decorator`) lets developers post-process the data in
both directions — for example the built-in `id_cleaner` strips environment-specific
IDs so entities don't collide across sites.

> **Important compatibility note.** In this branch (`5.0.x`, resolved as the `dev-5.0.x`
> development branch) the module is **broken on Drupal 11.4 and later**: enabling it
> makes every container build fatal, taking down `drush cr`, `drush en`, and web
> requests, and it can't even be uninstalled via Drush once the fatal occurs. The
> cause is a normalizer return-type signature that core's serialization module
> narrowed. Treat this branch as usable on **Drupal 10.1–11.3 only** until the
> signature is fixed, and pin/test carefully before enabling on production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, mind the Drupal
   version, and enable the module.
2. [Configuration](configuration/index.md) — declare the content sync directory in
   `settings.php`, the settings form, permissions, and how to run an export/import.

## Where it lives in the admin menu

Everything sits under **Configuration → Development → Content**
(`/admin/config/development/content`): the change list (created / updated / deleted),
export and import forms, a settings form, and a log screen. Four restricted
permissions govern who can do what.

## How to use it

The essential setup is: declare a content sync directory in `settings.php` (there is
no admin field for it — it mirrors core's config sync directory), then export from one
environment and import on another, either through the UI or with the Drush commands.
The full walkthrough is in [Configuration](configuration/index.md).
