# Automatic Site Icon Picker — manual setup guide

**Automatic Site Icon Picker** (`automatic_site_icon_picker`) is a favicon
picker/formatter for **Link** fields. For a link that points at another website, it
fetches or derives that site's favicon so the link can display the destination
site's icon automatically — no need to upload an icon for each link by hand.

It is a content‑display feature, built on core's **Field** module. Because it works
out the icon for the site a link points to, displaying it involves a request to that
**external site** for its favicon (a public asset). Set up caching so those icons
aren't re‑fetched on every page load, and make sure the display degrades gracefully
when a site has no reachable favicon. The module has no content or access role of
its own.

You turn it on per field, by choosing the favicon formatter on a Link field's
display configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [How to use it](#how-to-use-it) — apply the favicon formatter to a Link field.

## Where it lives in the admin menu

The module adds no admin menu item and no global settings page. You apply it per
field, at **Structure → (your entity type) → Manage display**.

## How to use it

1. Add (or reuse) a **Link** field on the entity/bundle you want to show icons for.
2. Go to that bundle's **Manage display** screen.
3. For the Link field, set the **Format** to the site‑icon (favicon) formatter this
   module provides.
4. Save. When the field renders, each link is shown with the favicon of the site it
   points to. Keep caching enabled so destination‑site favicons are reused rather
   than re‑fetched on every render, and expect the display to fall back gracefully
   when a site's favicon can't be reached.
