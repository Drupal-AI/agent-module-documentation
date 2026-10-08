# Popup Entity — manual setup guide

**Popup Entity** (`popup_entity`) adds a fielded **"Popup" content entity type** to your
site. Each popup you create is a piece of content in its own right — with whatever fields
you give it (body text, an image, a call to action) — and every *published* popup renders
as a dismissible modal that appears over the page. It's a content‑managed way to run
announcements, promotions, cookie/GDPR notices, or newsletter sign‑up modals without
touching code.

Because popups are real entities, they can be translated, given multiple view modes, listed
and managed from an admin collection, and gated with granular permissions. Each popup also
carries its own presentation settings: width and height (as a percentage of the viewport),
on‑screen position, an open delay, how many times a visitor should see it before it stops
(tracked in a cookie), the cookie's lifetime, and which theme breakpoints it should appear
on (so you can, for example, show it on desktop but not mobile). Where a popup appears is
controlled by visibility rules provided by the required **Entity Content Visibility** module,
much like Drupal's block visibility conditions.

One caveat worth knowing before you build: every active popup is loaded on each page so the
module can decide whether to show it. A handful of popups is fine; several dozen will start
to affect performance.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable it, and
   grant the popup permissions.

There is **no site‑wide settings form** in the usual "Configuration" sense — you configure
each popup on the popup entity itself. See "How to use it" below.

## Where it lives in the admin menu

Popup Entity does not add a page under *Configuration*. Instead it gives you:

- **Add a popup** — `/popup_entity_popup/add`
- **Manage popups** (the content collection list) — `/admin/content/popup_entity_popup`
- **Global settings** — `/admin/structure/popup_entity_popup_settings` (requires the
  *Administer popup entity* permission)

## How to use it

1. Grant the permissions you need on **People → Permissions** — *Add / Edit / Delete / View
   popup entity*, and *Administer popup entity* for the settings and collection pages. (See
   [Installation](installation/index.md) for the full list.)
2. Go to **`/popup_entity_popup/add`** and create a popup. Fill in its content fields, then
   set its presentation options:
   - **Width / Height** — entered as a percentage of the viewport.
   - **Position** — horizontal (left / middle / right) and vertical (top / middle / bottom).
   - **Open delay** — how long, in milliseconds, before the popup appears.
   - **Times to show** — the maximum number of impressions before it stops appearing (0 means
     always show). The count is stored in a per‑popup cookie.
   - **Cookie expiration** — how long, in minutes, that impression cookie lives.
   - **Breakpoints** — the theme breakpoints the popup should appear on, so you can limit it
     to (say) desktop widths only.
3. Set the popup's **visibility conditions** (which pages, content types, languages, roles,
   and so on) using the Entity Content Visibility rules, just as you would for a block.
4. **Publish** the popup to make it live. Un‑publish it later to hide it without deleting it.

Visitors can dismiss any popup with its close button, and once it has been shown its
configured number of times it stops appearing for that visitor.
