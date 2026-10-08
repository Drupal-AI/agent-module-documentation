# Configuration

There is no settings page — you configure Media oEmbed Control per field display.

## Turn on the options

1. Find a field that uses the core **oEmbed** field formatter to render a remote
   video (typically the source field on a remote‑video media type, or an entity
   reference rendered through it).
2. Go to that entity's **Manage display** for the view mode you want to affect
   (for example *teaser* versus *full*), and open the oEmbed formatter's settings
   by clicking its gear icon.
3. You'll see two new checkboxes:

| Setting | Default | Effect |
|---|---|---|
| **Autoplay video** | Off | Autoplays the embed when the provider allows it. |
| **Embed as background video** | Off | Plays the video as a silent, looping background video (no controls) — ideal for hero sections. |

4. Tick what you want, then **Update** and **Save** the display.

Because these are per‑display settings, you can give the same media field
different behaviour in different view modes — for example autoplaying a background
loop in a marketing display while leaving the standard display with normal
controls.

## What each option actually does to the embed

When the video renders, the module rewrites the iframe URL depending on the
provider:

- **YouTube** — always gets `enablejsapi=1` (so custom player scripting is
  possible). **Autoplay** adds `autoplay=1&mute=1` (YouTube autoplay is forced
  muted so browsers permit it). **Background** adds `background=1&controls=0&loop=1`
  and a self‑referencing `playlist` so it loops seamlessly.
- **Vimeo** — **Autoplay** adds `autoplay=1`; **Background** adds `background=1`
  (silent, looping, chromeless via Vimeo's own background mode).

Any other oEmbed provider is left exactly as core renders it.

## Good to know

- **Security is preserved.** The module's iframe controller runs core Media's
  signed‑hash check before it rewrites anything, so the embed is still protected
  the way core intends.
- **Unchecking both options** removes the extra settings entirely from stored
  configuration, keeping your config clean.
- The active options show up in the formatter's **settings summary** line
  ("Oembed control: …") so you can see at a glance which displays have them on.
