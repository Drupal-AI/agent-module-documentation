# DGA Rating — manual setup guide

**DGA Rating** (`dga_rating`) provides an accessible 1–5 star rating widget that
lets visitors evaluate a service, content page, or any entity, optionally leaving
written feedback. It shows live statistics — the average rating (for example
"3.9") and total number of reviews — and submits ratings asynchronously via AJAX,
so the page never reloads. It can track ratings by entity (node, user, and so on)
or by URL, and works for both authenticated and anonymous visitors.

The widget is built to the **DGA (Digital Government Authority) Design System**,
with keyboard navigation, ARIA labels for screen readers, and a responsive,
mobile-friendly layout. In its closed state it shows the average and review count
with a "Rate this service" button; opening it reveals the star selector, an
optional feedback textarea, and a submit button; after submitting, a confirmation
view thanks the user and the updated statistics flow back into the closed view.

The widget is delivered as a **block**, so it appears only where you place it,
and there is no site-wide settings form — each placement is configured in its own
block settings. It runs on Drupal 10 and 11, needs PHP 8.1 or higher, and has no
external dependencies.

Because ratings and feedback are **submitted by visitors**, treat the free-text
feedback as untrusted input, apply anti-abuse/flood measures so totals can't be
gamed, and expose only the aggregate statistics.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no site-wide configuration page** — the widget is a block, and each
placement is configured in its own block settings. Placement and use are
described under "How to use it" below.

## Where it lives in the admin menu

DGA Rating adds no dedicated admin settings page. You place and configure the
**DGA Rating Widget** block under **Structure → Block layout**
(`/admin/structure/block`).

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the **DGA Rating Widget** block and place it in the region you want —
   Content, Sidebar, or Footer, for example.
3. Adjust the block's settings (including its **Visibility** conditions to limit
   where it appears) and save the block layout.
4. Clear the cache if the widget doesn't appear immediately (`drush cr`).

The widget automatically detects the current page context, fetches the existing
average and review count, and updates the statistics after each submission.

> **Theming:** To restyle the widget, copy
> `templates/dga-rating-widget.html.twig` from the module into your theme's
> `templates/` directory and override it there.
