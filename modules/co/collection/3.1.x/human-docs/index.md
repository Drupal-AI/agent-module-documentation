# Collection — manual setup guide

**Collection** (`collection`) lets you group content and configuration entities
into named **collections** — with owners, per-collection membership, and their own
landing/overview pages. It is a way to model things like blogs (collections of
posts), periodicals (collections of articles), sub-sites (a section of the site with
its own pages and menu), or personal curated sets of content.

The building blocks mirror Drupal's own content model. **Collection entities** are
fieldable and revisionable and can act as content pages in their own right;
**Collection types** work like content types; and **Collection item entities** (with
their own **Collection item types**) are the join objects that link a node — or even
a configuration entity like a menu — into a collection. A single piece of content can
live in several collections at once, with one designated as its canonical (primary)
collection, and items can be ordered within a collection.

This module needs a little setup before it does anything: you enable it, then define
at least one collection type and start creating collections. It builds on
**Dynamic Entity Reference** and **Inline Entity Form** and also requires core
**Path** and the **Key value field** module. Two optional bundled submodules extend
it: **Collection Listing** (experimental) lets you place listings of a collection's
items as Paragraphs, and **Collection Pathauto** prepends a collection's URL alias to
its items' aliases when Pathauto is present.

It is worth knowing how Collection differs from the similar **Group** module:
Collection uses join entities much like Group does, but it does **not** create custom
per-collection roles and permissions, and it *does* let you place configuration
entities (such as menus) into a collection. Its own permissions are granular —
site-wide administration plus owner-scoped view/edit/delete — and the `administer`
permissions are powerful, so restrict them to trusted roles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside its dependencies.
2. [Configuration](configuration/index.md) — collection types, permissions, and
   the optional submodules.

## Where it lives in the admin menu

Collection types are managed under **Structure** (alongside content types), the
collections themselves appear under **Content**, and the module's permissions live
on **People → Permissions** (`/admin/people/permissions`).
