# Context Active Trail — manual setup guide

**Context Active Trail** (`context_active_trail`) adds an **Active trail**
reaction to the [Context](https://www.drupal.org/project/context) module, letting
you force the active menu trail — and optionally the breadcrumb — of a page based
on the context it matches. It is the answer to "this page isn't a menu link, but
I want the right menu item highlighted anyway."

A classic example: make every *article* node behave as though it lives under the
*Blog* menu item, so the Blog link is highlighted and its menu expands, no matter
what URL the article actually has. Because you decide *which* pages this applies
to using Context's own condition system (path, content type, role, language, and
so on), you get a lot of flexibility — different sections, different roles, even
different languages can each get their own trail.

Under the hood, the module overrides core's active‑trail service so that matching
contexts are consulted first, falling back to Drupal's normal behavior when no
context matches. It can also rebuild the **breadcrumb** from that forced trail
using a high‑priority breadcrumb builder, with an option to append the current
page title. It keeps everything correct with dedicated cache tags that are
cleared whenever an active‑trail reaction is saved or deleted.

> **Compatibility note:** this module takes over the active trail, so it is
> **incompatible with other modules that do the same**, such as *Menu Trail By
> Path*. Don't run two active‑trail overrides at once.

This module has **no settings page of its own** — you configure it entirely
through Context (the Context UI is recommended).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — the service override and
breadcrumb builder — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Context module) and enable it.

## Where it lives in the admin menu

There is no standalone form. You add the **Active trail** reaction inside a
context at **Structure → Context** (`/admin/structure/context`), which needs the
Context UI submodule.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Context** and create or edit a context.
3. Add the **conditions** that decide when it applies (for example, content type
   = Article).
4. Add the **Active trail** reaction and fill in its fields:
   - **Menu parent selector** (`trail`) — the menu link to force as the active
     trail, chosen with the standard menu‑parent selector (default `main:`).
   - **Override breadcrumbs** (`breadcrumbs`, on by default) — rebuild the
     breadcrumb from the forced trail.
   - **Show current page title at end** (`breadcrumb_title`, off by default) —
     append the current page title as a final, non‑link breadcrumb crumb. Only
     available when *Override breadcrumbs* is on; leave it off if another module
     already handles breadcrumbs.
5. Save the context. Pages that match it now use the forced menu trail (and
   breadcrumb). When no context matches, Drupal's normal active‑trail behavior
   takes over — nothing is forced.
