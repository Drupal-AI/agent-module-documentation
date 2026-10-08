# Display Link Plus — manual setup guide

**Display Link Plus** (`display_link_plus`) extends Drupal core's *Display link*
Views **header/footer** plugin — the feature that lets one View link to another
display of itself. Core's version is bare: it just outputs the link. Display Link
Plus makes that link genuinely useful for building admin and public‑facing UIs by
adding the options core leaves out.

The problem it solves is building "link to a related display" into a View
gracefully. With this module you can perform an **access check** as part of the
render, so the link only appears for users who can actually reach the target
display; **override the link label**; add one or more **CSS classes** (for example,
to style the link as a button); and render the target display in the **settings
tray** or a **modal dialog**, optionally at a chosen width. It aims to build links
to common tasks directly into public‑facing Views — conceptually similar to *Add
Content By Bundle*, though for a different use case.

It is a Views‑only tool with **no configuration page of its own** and no
dependencies beyond core. All setup happens inside the Views UI when you add the
plugin to a View. It supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no settings page** for this module — you configure it inside the **Views
UI** when adding the header/footer plugin, described in "How to use it" below.

## How to use it

1. Edit a View at **Structure → Views** (`/admin/structure/views`), or create a new
   one, that has more than one display (this plugin links from one display to
   another).
2. In the View's **Header** or **Footer** section, click **Add** and choose the
   **Display Link Plus** (enhanced display link) plugin.
3. Configure its options:
   - **Target display** — which display of the View this link points to.
   - **Label override** — custom link text instead of the default.
   - **CSS classes** — one or more classes to apply to the link, e.g. to render it
     as a button.
   - **Open in settings tray or modal** — render the target display in Drupal's
     off‑canvas settings tray or a modal dialog, and optionally set a width.
   - The plugin also runs an **access check** automatically, so the link is hidden
     from users who cannot access the target display.
4. Save the View.

> **Link accessibility tips.** Make the link text meaningful on its own — screen
> reader users can pull a page's links out of context, so avoid bare URLs or
> repeated "read more". And treat opening in a new tab as a deliberate choice: where
> you do, ensure `rel="noopener"` is present so the opened page cannot reach back
> through `window.opener`.
