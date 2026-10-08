# Module Builder — manual setup guide

**Module Builder** (`module_builder`) auto‑generates the "scaffolding" for a custom
Drupal module — the boilerplate for hooks, plugins, forms, routes and controllers,
services, permissions, entity types, tests, an `api.php` file, an admin settings
form, a README, and more — along with hints on how to fill them in. It is a
developer tool, useful both for newcomers learning how Drupal code fits together and
for seasoned developers who would rather not look up every function signature by
hand.

What sets Module Builder apart from generic code generators is that it **analyses
your own site's code**. Instead of a fixed template, it detects the plugin types,
hooks, and services actually present in your installed core and contrib modules, so
the code it generates matches your environment. It saves each generated module as a
config entity, so you can come back later, add or change components, and regenerate.
It even has partial support for adopting an existing module as a config entity to
extend it further, plus experimental theme generation.

Under the hood it is a Drupal UI for the
`drupal-code-builder/drupal-code-builder` PHP library (`^4.6`), which Composer pulls
in automatically. The same library backs Drush's own `generate` commands, so the
output is consistent between the two. There is one optional submodule,
`module_builder_devel`, aimed at Module Builder's own developers.

> **Do not install this on production.** Module Builder can write PHP into your
> site's codebase. It should only ever run on a local or development environment,
> and its single permission (*Create modules*) must never be granted on a live site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (as a dev
   dependency) and enable the module.

There is no ordinary "settings" to tune here — the module's screens are the
generator itself. Setup and first use are covered below.

## Where it lives in the admin menu

Everything sits under **Configuration → Development → Module Builder**. The key
pages are:

- **Analyse** (`/admin/config/development/module_builder/analyse`) — scans your
  site's code to build the generator's knowledge of hooks, plugin types, and
  services.
- **Settings / Modules** (`/admin/config/development/module_builder/settings`) —
  where you create and manage module config entities.

All of these pages are gated by the single **Create modules** (`create modules`)
permission, which is correct because they write code into your codebase.

## How to use it

1. After installing and enabling (see [Installation](installation/index.md)), go to
   **Configuration → Development → Module Builder → Analyse** and run the code
   analysis. **Do this first** — the generator builds its picture of available
   hooks, plugin types, and services from *this* site's code, so the output matches
   your installed core version and enabled modules rather than a generic template.
2. Go to the **Modules** screen and add a new module entity, giving it a name and
   machine name.
3. Choose the components you want (hooks, plugins, a settings form, permissions,
   services, tests, a README, and so on) and generate the code.
4. Return any time to add or change components and regenerate — the module's
   definition is stored as a config entity.
5. **Re‑run the analysis** after upgrading core or adding modules, so the generator
   stays in sync with what your site now provides.
