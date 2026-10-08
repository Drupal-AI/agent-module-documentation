# SoundCloud Field — manual setup guide

**SoundCloud Field** (`soundcloudfield`) adds a dedicated **SoundCloud** field type for
storing a SoundCloud track or set (playlist) URL and displaying it as an embedded player.
Rather than pasting embed codes into a body field, editors just enter a SoundCloud URL and the
field renders a proper player — ideal for podcast archives, music libraries, or any content
that features audio.

The field validates that the value points at `soundcloud.com` before it saves, so you don't
end up with broken embeds. It comes with **four display formatters** so you can choose how the
URL is rendered: a **Default (PHP-based)** player that builds the embed on the server via
SoundCloud's public oEmbed endpoint, a **JavaScript** player that renders client-side using
SoundCloud's JS SDK, a plain **Link** to the track, or the **raw URL** as text. No SoundCloud
API key is required — the oEmbed endpoint is public.

Both player formatters give you the usual SoundCloud options on the display settings: classic
(compact) versus visual (large artwork) player, width, height (with a separate height for
sets/playlists), accent color, autoplay, and toggles for artwork, comments, play count, user
info, and related tracks. Heights even auto-adjust when the URL is a set rather than a single
track. There is no global settings page and no permissions — everything is configured
per-field on *Manage form display* and *Manage display*. It depends only on core's **Field**
module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent — including every formatter setting key — read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

There is no configuration page — you use it like any Drupal field:

1. **Add the field.** On the entity you want (for example **Structure → Content types →
   (your type) → Manage fields → Create a new field**), choose the **SoundCloud** field type
   and give it a label.
2. **Pick the input widget.** On **Manage form display**, the field uses the SoundCloud URL
   widget — an ordinary URL input. Its one option is a **placeholder URL** (example text shown
   in the empty box). Editors paste a track or set URL, which is validated against
   `soundcloud.com` on save.
3. **Choose how it displays.** On **Manage display**, pick one of the four formatters:
   - **Default (PHP-based)** — fetches the embed server-side via SoundCloud's public oEmbed
     endpoint and outputs an iframe player. (Requires the web server to be able to reach
     soundcloud.com when the page is rendered.)
   - **Javascript** — loads SoundCloud's JS SDK and renders the player in the visitor's
     browser. (Requires the visitor's browser to reach the SoundCloud CDN.)
   - **Link to SoundCloud URL** — a plain hyperlink, with options to trim the link text, add
     `rel="nofollow"`, and open in a new window.
   - **Raw output of SoundCloud URL** — emits the URL as plain text, handy for theming or
     feeds.
4. **Tune the player.** For either player formatter, the display settings let you choose the
   **classic** or **visual** player, set **width** (as a percentage), **heights** for single
   tracks and for sets, the **accent color** (a hex value, default `ff7700`), **autoplay**,
   and whether to show **artwork, comments, play count, user info, and related tracks**.

If a track is private or unavailable, the default formatter shows a graceful "content not
available / private" message rather than breaking the page.
