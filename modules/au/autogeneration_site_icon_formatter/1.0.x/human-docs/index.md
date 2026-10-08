# Autogenerate site icon formatter — manual setup guide

**Autogenerate site icon formatter** (`autogeneration_site_icon_formatter`) is a
field formatter for core **Link** fields that shows each link together with the
favicon of the site it points to. Instead of uploading an icon for every social or
partner link by hand, you let the formatter fetch each site's favicon
automatically. It is well suited to a row of social‑media profile links, a list of
sponsors or partners, or any set of outbound links that reads better with
recognizable site icons.

When a link is rendered, the formatter reads the host from the link's URL and
requests an icon for that host from a favicon service (using Drupal's HTTP client).
The response is checked against an allow‑list of icon/image content types and a
1 MB size cap, then saved under `public://social-media-icons/` and reused on later
renders. If no icon can be fetched — a bad URL, the wrong content type, an oversize
file, or a network error — a bundled default SVG is shown instead. You can override
that fallback by placing `images/icons/default_social_link.svg` in your active
theme.

Because it fetches icons at render time, the module makes a server‑side outbound
HTTP request per distinct host and writes files into the public files directory, so
it needs outbound network access and a writable public filesystem. The host it
looks up comes from the editor‑controlled link value and is appended as a path
segment to a fixed third‑party favicon service rather than being fetched directly.
It is purely a display module: it has no routes, permissions, or forms of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [How to use it](#how-to-use-it) — apply the formatter to a Link field and choose
   its display options.

## Where it lives in the admin menu

The module adds no admin menu item and no global settings page. You apply it per
field, at **Structure → (your entity type) → Manage display**.

## How to use it

1. Add (or reuse) a **Link** field on the entity/bundle you want to show icons for.
2. Go to that bundle's **Manage display** screen.
3. For the Link field, set the **Format** to **Link (favicon)**
   (`social_media_link`).
4. Click the gear icon to choose the display options:
   - **Display view** — **Icon only**, **Icon and URL**, or **Icon and Title**.
   - **Icon size** — **64px** (large), **32px** (medium, the default), or **16px**
     (small).
5. Make sure the public files directory is writable. On first render each link's
   favicon is fetched and cached under `public://social-media-icons/`; delete a
   cached file to force it to be re‑fetched. Fetch or write errors are logged to the
   **Social media icon** logger channel, and the default icon is shown in their
   place.
