# Configuration

Happy New Year's settings form lives in the **Configuration** area of the admin
menu. Open it as a user with permission to administer site configuration.

## The settings

- **Time interval (active dates)** — the date range during which the garland and
  snow are shown. Set it to your holiday window so the decoration appears
  automatically at the start of the season and stops at the end, with no need to
  enable and disable the module by hand.
- **Snow color** — the color of the falling snow. This is more than cosmetic
  polish: on a light or white-themed site, plain white snow is invisible, so
  choosing a contrasting color makes the effect actually show.
- **Use minified libraries** — when enabled, the module loads the minified
  versions of its JavaScript/CSS for a smaller payload. Leave this on in
  production for better performance; the unminified versions are mainly useful for
  debugging.

Save the form when you're done.

## A note on placement and performance

The garland is designed to sit **below** your site chrome rather than behind it —
it automatically drops beneath the admin toolbar and beneath a fixed Bootstrap
navbar, so it won't overlap your menus. Because the snow is an animated overlay,
it does use some client-side resources; that's rarely a problem, but it's the
reason the effect is best switched on only for the season.

## Verify

Load a front-end page within the active date range and confirm the garland and
snow appear, that the snow color is visible against your theme, and that the
garland sits below your toolbar/navbar rather than behind it.
