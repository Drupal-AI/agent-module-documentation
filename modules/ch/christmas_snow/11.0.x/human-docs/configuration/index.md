# Configuration

Everything Christmas Snow does is driven by one settings form. The module ships
**no default configuration**, so nothing happens until you open this form, turn the
effect on, and save.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default). The module defines no permissions of its own.
2. Go to **Configuration → Christmas Snow → Christmas Snow settings**, or navigate
   directly to `/admin/config/christmas_snow/cs_settings`.

## The settings, field by field

- **Enable snow** — the master switch (a checkbox, off by default). While this is
  unticked, the module attaches nothing to your pages. Tick it to turn the
  snowfall on.
- **Maximum snow flakes** — how many flakes are on screen at once: 16, 32, 64, 128
  (default), or 512. Think of it as "a light flurry" through to "a nor'easter".
  Higher counts look heavier but use more CPU.
- **Snow color** — a hex colour value (default `#FFFFFF`, i.e. white). The form
  provides a Farbtastic colour picker so you can pick a shade visually instead of
  typing a hex code.
- **Flakes on the bottom** — how deep snow is allowed to pile at the bottom of the
  viewport: 500 (default), 750, or 1000.
- **Flakes follow mouse** — when on (default), flakes drift toward the mouse
  pointer, giving a gentle "wind" effect. Turn off for a straight, even fall.
- **Flakes melt away** — when on (default), recycled flakes fade out rather than
  vanishing abruptly.
- **Flakes stick** — whether snow settles at the bottom of the window (default is
  *no*, flakes never settle).
- **Flakes twinkle** — adds a flicker/twinkle to falling flakes (off by default).
- **Flake character** — the glyph used for each flake: a bullet `•` (default) or a
  middot `·`.
- **Performance** — the animation frame interval in milliseconds per frame: 20, 33
  (default), or 50. A smaller number is smoother but works the CPU harder; a larger
  number is lighter but choppier.
- **Use minified libraries** — a checkbox (off by default) that serves the minified
  Snowstorm build (`snowstorm-min`) instead of the full one, for a slightly smaller
  payload.

Click **Save configuration** to apply. Reload any front-end (non-admin) page to see
the effect. The output carries a cache tag tied to this config, so changes clear
cached pages correctly.

## Important: making the snow actually appear (the dead CDN)

The module declares the Snowstorm library as an **external asset loaded from
`cdn.rawgit.com`** — a CDN that has been shut down. On most sites this means that
even with *Enable snow* ticked, the browser cannot fetch Snowstorm and no flakes
appear.

To fix it, point the library at a working copy of Snowstorm (for example a file you
download and place inside your own theme or module, or a maintained CDN URL). You do
this by overriding the module's library definition — typically with
`hook_library_info_alter()` in a small custom module, or a `libraries-override` entry
in your theme's `*.info.yml`, repointing the `snowstorm` / `snowstorm-min` library to
your hosted file. The [`agent/`](../agent/start.md) docs describe exactly which
library keys to override.

## Setting values without the UI

You can script the settings with Drush, for example:

```bash
ddev drush config:set christmas_snow.settings christmas_snow 1 -y
ddev drush config:set christmas_snow.settings christmas_snow_snowcolor '#FFFFFF' -y
```
