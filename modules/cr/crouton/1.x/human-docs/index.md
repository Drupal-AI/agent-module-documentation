# Crouton — manual setup guide

**Crouton** (`crouton`) replaces Drupal core's path-based breadcrumb builder with a
**menu-based** one. Instead of deriving the breadcrumb trail from the URL, Crouton
builds it from a menu you choose: it follows the active menu trail for that menu and
turns each item in the trail into a breadcrumb link, using the item's label and
target. The result is a breadcrumb that mirrors your site's information architecture
rather than its URL structure — which is usually far more meaningful to visitors.

Because it works from menu items, you get real flexibility: you can use *any* menu
(even one that isn't shown to users), and breadcrumb labels are decoupled from the
target content, so a breadcrumb can read differently from the page title it links to.
With a properly structured template, the current page is automatically marked with
`aria-current="page"`. A short settings form lets you decide whether to include a
Home link and a link for the current page, whether to use disabled menu items, and
whether to show structural-only items.

Crouton is a navigation/display convenience with no security surface. It works on
Drupal 10.1 and 11, has no other module dependencies, and defines a permission for
administering its settings. The one thing to get right is picking the source menu so
it matches your site's information architecture.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose the breadcrumb menu and tune the
   Home/current-page and disabled-item options.

## Where it lives in the admin menu

Crouton's settings are reached from its **Configure** link on the **Extend**
(modules) page, and its permissions from the **Permissions** link there. See
[Configuration](configuration/index.md) for the full walkthrough.
