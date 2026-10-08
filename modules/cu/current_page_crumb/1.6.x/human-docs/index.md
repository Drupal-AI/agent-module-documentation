<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Current Page Crumb — manual setup guide

**Current Page Crumb** (`current_page_crumb`) adds the current page's title to the
end of the breadcrumb trail, as a plain (unlinked) final crumb. So instead of a
trail like `Home › Blog`, visitors see `Home › Blog › My Article Title` — the
breadcrumb ends with the name of the page they are actually on.

It works the moment you enable it — there is nothing to configure. Under the hood
it replaces Drupal's default breadcrumb builder with one that first builds the
normal path-based trail and then appends the current route's title. If a page has
no resolvable title, it derives a readable label from the URL (turning a slug like
`annual-report` into `Annual report`). The extra crumb is intentionally left
**unlinked**, so it doesn't look clickable.

It is deliberately well-behaved: it leaves **admin pages** and the **front page**
untouched, and it adds correct cache metadata (including the right cache tags on
Views pages) so breadcrumbs invalidate properly. It is dependency-free — core
only — with no settings, no permissions, and no Drush commands.

> **One prerequisite:** the module only changes what the breadcrumb *contains*, it
> does not render the breadcrumb itself. Your theme must have the core
> **Breadcrumb** block placed (for example in Olivero's breadcrumb region) for any
> breadcrumb to appear at all.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

The module has no configuration page — enabling it is the entire setup.

## Where it lives in the admin menu

Nowhere — there is no admin form or menu item. Once enabled, richer breadcrumbs
appear automatically on front-end pages wherever the Breadcrumb block is placed.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Make sure the core **Breadcrumb** block is placed in your active theme at
   **Structure → Block layout**.
3. Visit a front-end page — the breadcrumb now ends with that page's title. Admin
   pages and the front page are left unchanged by design.

To turn it off, simply uninstall it — breadcrumbs revert to Drupal's default
path-based trail with no title crumb.
