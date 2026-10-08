# Simple Popup Blocks — manual setup guide

**Simple Popup Blocks** (`simple_popup_blocks`) turns any Drupal block, form, view, or
custom `div` into a popup or modal by pointing at it with a CSS selector. You create
each popup from an admin form, choose where it appears on screen, how it is triggered,
and how often it shows — no theme changes required for the basic behavior.

Each popup you create is saved as its own configuration object. You do not put content
*into* the popup; instead you tell the module which existing element on your page to
show. A popup can target either a **Drupal block** (by its block id) or an **arbitrary
CSS id or class** (any element already in your markup). From there you pick a screen
layout (corners, center, top/bottom/left/right bars), a trigger (automatically after a
delay, on click of a selector, or just before the visitor closes the tab), and a
display frequency (which visit numbers, or a time‑based throttle).

Common uses are a newsletter signup as a centered modal, a cookie/GDPR notice as a
bottom bar, an exit‑intent discount offer, or a click‑to‑open contact panel. The
module ships **no default popup styling** — the edit page lists the CSS selectors it
generates for each popup so you can style them in your theme. Remember to clear caches
after creating or editing a popup so the change appears.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — every config key and its enum
values — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — creating a popup, every option on the
   form, styling, and managing existing popups.

## Where it lives in the admin menu

Create popups at **Configuration → Media → Add simple popup blocks**
(`/admin/config/media/simple-popup-blocks/add`), and manage, edit, or delete existing
ones at `/admin/config/media/simple-popup-blocks/manage`. Both are gated by the
**Administer simple_popup_blocks** permission.
