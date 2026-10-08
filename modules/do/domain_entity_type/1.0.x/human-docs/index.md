# Domain Access Entity Type — manual setup guide

**Domain Access Entity Type** (`domain_entity_type`) lets you control access to an
*entity type* by domain in a
[Domain](https://www.drupal.org/project/domain) (Domain Access) installation. It
builds on the Domain module, which runs several sites from one Drupal install. The
use case is when you want a whole entity type — for example a particular content
type — to be available only on one domain rather than on all of them.

Concretely, it scopes entity-type **list builders and menus** per domain, so which
domains see which entity-type listings and admin menu links is governed by domain.
It provides its own permissions to manage this.

An important boundary to understand: this module manages access to entity *types*
(listings and menus), **not** the individual content items themselves. If you need
to control access to actual content by domain, that is the job of Domain Access's
node grants, or of the separate
[Domain Entity](https://www.drupal.org/project/domain_entity) module — this one
*complements* those, it does not replace them. Verify how it composes with the rest
of your Domain Access configuration before relying on it as an access boundary.

The module works within the Domain ecosystem once enabled and its permissions are
granted; the behavior is driven by your domain assignments rather than a
standalone settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (alongside the
   Domain module), enable it, and grant its permissions.

There is **no standalone settings form** documented for this module; it operates
through the Domain ecosystem and its own permissions, described in "How to use it"
below.

## Where it lives in the admin menu

Domain Access Entity Type does not add a general site-configuration page. It works
within the Domain admin area and affects the entity-type list builders and menus
you already use, scoping them by domain.

## How to use it

1. Ensure the **Domain** module is configured with your domains created.
2. Enable the module and grant its permissions to the appropriate roles (see
   [Installation](installation/index.md)).
3. Use it to scope which domains see which entity-type listings and menus.
4. Remember it governs entity-type listings/menus, not per-item content access —
   pair it with Domain Access node grants (or Domain Entity) if you also need to
   restrict the content itself.
