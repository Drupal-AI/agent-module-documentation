# Content Synchronizer — manual setup guide

**Content Synchronizer** (`content_synchronizer`) moves real content between
Drupal environments. It exports content entities — nodes, taxonomy terms, files,
paragraphs, users, and so on — into a single portable `tar.gz` archive, and
imports that archive into another site. So you can push freshly authored pages
from staging to production, pull production content down to a developer's local,
or hand a colleague a `.tar.gz` of seed content to load into their own copy.

It's built around two content entity types you manage from a dashboard. An
**Export entity** is a named, reusable set of things you want to ship — build it
once, then re-export it whenever the content changes. An **Import entity** is an
uploaded archive plus the state of running it into the site. When it exports, the
module walks each entity's fields and automatically pulls in the entities they
reference (the term a node uses, the images it embeds, the paragraphs it
contains), so relationships travel together. A global-reference system maps every
exported entity to a stable UUID, so those relationships reconnect correctly on
the far side and updates land on the right existing content.

On import you control two things: a **publish strategy** (publish the new content,
leave it unpublished for review, or import it as a new revision) and an **update
strategy** (always overwrite existing content, overwrite only when the incoming
copy is newer, or never touch content that already exists). Everything is
available from the admin dashboard, from bulk-export actions in Views listings,
from a one-click Quick Export link, and from **Drush** commands for CI and
headless use. A set of permissions separately gates the dashboard and the
creating, editing, and administering of Export and Import entities.

The module requires core's **File** module and the `cocur/slugify` PHP library
(Composer pulls the latter in for you). It is a developer- and operations-focused
tool — there is no global settings form; you work through the dashboard.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   `cocur/slugify` library) and enable the module.
2. [Configuration](configuration/index.md) — the dashboard, building an Export
   entity, running an Import, the publish and update strategies, the permissions,
   and the Drush commands.

## Where it lives in the admin menu

The dashboard is at **Content → Content Synchronizer**
(`/admin/content_synchronizer`). The two entity collections live under
**Structure** — Export entities at `/admin/structure/export_entity` and Import
entities at `/admin/structure/import_entity`. There is no settings page.

## How to use it

In short: on the source site, build an **Export entity** listing the content you
want, launch it, and download the `tar.gz`. On the destination site, create an
**Import**, upload that archive, pick your publish and update strategies, and
launch it. See [Configuration](configuration/index.md) for the full walk-through
and the Drush equivalents.
