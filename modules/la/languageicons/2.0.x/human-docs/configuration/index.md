# Configuration

Language Icons works with sensible defaults the moment it is enabled — the settings
form is only for fine‑tuning where the flags sit, how big they are, and which icon
set to use.

## Open the settings form

1. Log in as a user with the core **Administer languages** permission (an
   administrator by default).
2. Go to **Configuration → Regional and language → Language icons**, or navigate
   directly to `/admin/config/regional/language/icons`.

## Settings, field by field

- **Placement** — where the flag appears relative to the language name:
  - **Before** *(default)* — flag, then the language name.
  - **After** — the language name, then the flag.
  - **Replace link** — show only the flag and hide the text, for a compact,
    flag‑only switcher.
- **Size** — the icon dimensions as `WIDTHxHEIGHT` in pixels (default `16x12`). The
  bundled flags are 12 pixels tall, so `16x12` matches them; enter something like
  `24x18` if you swap in a larger icon set.
- **Path** — the location of the icon files, written as a pattern where `*` stands
  in for the language code. The default points at the module's bundled
  `flags/*.png`, so, for example, German resolves to `.../flags/de.png`. Point this
  at your own directory (for instance `sites/default/files/flags/*.png`) to use a
  custom or SVG icon set.

Click **Save configuration** when you are done.

> **A note on the two "Show on…" checkboxes.** The form contains **Show on node
> links** and **Show on the language switcher block** options, but they are
> currently disabled because of a long‑standing upstream bug. In practice icons are
> added to language switch links regardless, since both settings default to on — so
> you do not need to touch them.

## Make sure the switcher is visible

The icons only appear where language links are rendered. If you do not see any,
place the core **Language switcher** block in a visible region from **Structure →
Block layout** (`/admin/structure/block`) and confirm you have at least two
languages configured. Placing it in a sidebar together with the **Replace link**
placement gives you a tidy, flag‑only language menu.

## Styling and overrides

Each flag image carries the CSS class `language-icon`, so you can target it from
your theme's stylesheet. To change the markup around the icon and text, copy the
module's `languageicons-link-content.html.twig` template into your theme and edit it
there.

## Deploying settings between environments

All of these options live in the `languageicons.settings` configuration object, so
you can export them with your site's configuration and deploy consistent placement,
size, and icon path across environments.
