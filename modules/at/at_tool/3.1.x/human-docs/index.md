# AT Tool — manual setup guide

**AT Tool** (`at_tool`) is the module-side helper for the **Adaptivetheme** (AT)
theme system on Drupal 10 and 11. It is not a feature you configure or a UI you
click through — it is a small support layer that Adaptivetheme sub-themes rely on.
On its own it adds no content, no settings page, and no admin menu items; it wires
up a handful of theme-developer conveniences and then stays out of your way.

What it actually does happens at the theme layer: it can inject a **LiveReload**
script so the browser refreshes automatically while you edit a sub-theme, it swaps
in the correct **layout-settings stylesheet** on a theme's admin layout form, it
styles the **Appearance** page and tags each theme selector with its own CSS class,
and it provides a small **breadcrumb-title** lazy builder that AT themes use to
place the current page title inside the breadcrumb. All of this is driven by the
**active Adaptivetheme sub-theme's own settings** — AT Tool reads those settings
and reacts, rather than offering settings of its own.

Because it is a companion to a theme, AT Tool only makes sense alongside the
Adaptivetheme base theme (installed with Composer as `drupal/adaptivetheme`). On a
non-Adaptivetheme theme such as Olivero, the settings it looks for simply are not
present, so its developer features stay dormant. This 3.x release is the Drupal
10/11 successor to the older AT Tools module.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install AT Tool and the Adaptivetheme
   base theme with Composer, then enable the module.

## How to use it

There is **no settings form** for AT Tool (its `configure` route is `null`). Once
the module is enabled, its behavior is controlled entirely by the settings of the
**active theme** — that is, an Adaptivetheme sub-theme. AT Tool looks at these keys
in the active theme's settings (`<theme>.settings` → `settings`):

- **`enable_devel`** — the master gate for developer features.
- **`enable_live_reload`** — when on (together with `enable_devel`), injects a
  LiveReload script so the page auto-refreshes as you save changes.
- **`live_reload_port`** — the port LiveReload listens on (default `35729`); the
  script is loaded from `//localhost:<port>/livereload.js`.
- **`layouts_enable`** — when on, AT Tool swaps in the matching layout-settings
  form stylesheet on admin routes.

You set those flags in the sub-theme's appearance settings (or in the theme's
config), not in AT Tool. If you are theming with Adaptivetheme, turn on developer
mode and LiveReload there and AT Tool does the rest.

For theme developers there is also one reusable piece of code: the
`at_tool.lazy_builders` service, whose `breadcrumbTitle()` callback returns a
render array (`#theme => page_title__breadcrumb`) for placing the current page
title in the breadcrumb region. See the [`agent/`](../agent/start.md) docs for the
exact call.

Note that the Adaptivetheme project also ships **starterkit themes** (AT SKIN,
STARTERKIT, and the AT Theme Generator). Those are *themes*, not modules — do not
try to enable them as modules.
