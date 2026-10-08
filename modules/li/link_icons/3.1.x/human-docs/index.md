# Link Icons formatter — manual setup guide

**Link Icons formatter** (`link_icons`) is a field formatter for core's Link
field that displays a **Font Awesome brand icon** for the service a link points
to — a Facebook glyph for a `facebook.com` URL, a LinkedIn glyph for LinkedIn, an
X/Twitter glyph, and so on — instead of, or alongside, the plain link text. A
generic globe icon is used for any hostname it does not recognise.

The classic use case is a "Follow us" block: rather than half a dozen link fields
and a theme template that reinvents the URL‑to‑icon mapping every time, you point
this formatter at your link field and it recognises the service and emits the
right icon. It ships a large catalogue of recognised brands — Facebook,
Instagram, YouTube, GitHub, Mastodon, Bluesky, Spotify and dozens more.

The recognised services live in the optional **Link Icons Brands** submodule
(`link_icons_brands`), which imports the brand definitions as configuration
entities — each one mapping a hostname to an icon, colour, and CSS class. Because
they are config, the set is extendable: you can add a brand the module does not
ship, or override one, from the services configuration page without writing code.

Two dependencies matter. The formatter needs the contrib **Font Awesome** module
to make the icons actually available, and core **Link** for the field itself. If
Font Awesome is not loading its library on the pages where your links appear, the
formatter emits the icon markup but there is nothing to render it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and the Brands submodule, and confirm Font Awesome is loading.
2. [Configuration](configuration/index.md) — the per‑field formatter options and
   the site‑wide services page where brand mappings are managed.

## Where it lives in the admin menu

The formatter itself is chosen per field on **Structure → Content types → *(your
type)* → Manage display**. The site‑wide brand mappings are managed at
**Configuration → Search and metadata → Link icon services**
(`/admin/config/search/link_icon_services`), and each service field is explained
on the module's help page at `/admin/help/link_icons`. Managing brands is gated
by the **Administer link icon services** permission.

## How to use it

1. Add or reuse a **Link** field on your entity (for example a set of social
   links on a content type or user profile).
2. On **Manage display**, set that field's format to **Service icon (with
   options)** and save.
3. Click the settings gear next to the formatter to tune how the icons appear —
   whether to show the label, the icon size, and other Font Awesome options (see
   [Configuration](configuration/index.md)).
4. If a service you use is not recognised, add or adjust its mapping on the **Link
   icon services** page.
