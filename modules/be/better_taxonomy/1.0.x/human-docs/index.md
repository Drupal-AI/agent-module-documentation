# Better Taxonomy — manual setup guide

**Better Taxonomy** (`better_taxonomy`) adds usability and management
improvements on top of Drupal core's Taxonomy system. It refines how you work
with vocabularies and terms day to day, aiming to make the core taxonomy
experience a little more convenient than core alone — without replacing it. It
depends only on core's Taxonomy module and lives in the Taxonomy package.

There is nothing to configure and no new admin section to learn: you keep
managing vocabularies and terms exactly where you already do, and the module's
refinements apply there. Term and vocabulary access continue to follow core
taxonomy access — Better Taxonomy adds no permissions or access-control role of
its own.

This guide is written for a **human** clicking through the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, Better Taxonomy works automatically — there is no settings form
to fill in. Manage your vocabularies and terms the usual way at **Structure →
Taxonomy** (`/admin/structure/taxonomy`), and the module's usability
improvements apply to that experience. Because access follows core taxonomy
behaviour, no extra permission setup is required.
