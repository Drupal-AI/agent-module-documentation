# Custom Bootstrap Icon Font — manual setup guide

**Custom Bootstrap Icon Font** (`custom_bootstrap_icon_font`) generates a compact
custom **WOFF2 icon font** (plus optional WOFF) and matching CSS from only the
**Bootstrap Icons** and/or **Font Awesome** SVGs your site actually uses. Instead
of shipping an entire icon library, you pick the handful of icons you need and the
module builds a small, focused font and stylesheet just for those — keeping your
front end lightweight.

You select icons on an admin form — by name, by class, or by pasting
`<i class="bi ...">` snippets — with Bootstrap Icons and Font Awesome kept in
separate lists. A font generator (**Fantasticon**, invoked as `npx fantasticon` by
default) then produces the font under `public://custom_bootstrap_icon_font/font/`.
Codepoints are stored in config so a re‑added icon keeps its stable glyph value
across rebuilds, and the generated CSS maps `.di-<icon>` classes to glyphs. The
module auto‑attaches that CSS on the front end (with a cache‑busting `?v=`), so you
don't need to edit your theme, and a Twig helper is provided for rendering icons in
templates.

Building can be triggered from a button on the admin form (handy for local/dev) or
via a **Drush command** (recommended for CI/deploy). The whole surface is gated
behind a dedicated **`administer custom bootstrap icon font`** permission, and the
generator runs via Symfony's `Process` using an argument array — there's no shell
string, so no shell injection.

This module has real setup prerequisites: it needs the source SVGs on disk under
`web/libraries/…`, a writable `public://`, and Node tooling (Fantasticon) available
to whatever runs the build. It depends on core **File** and works on Drupal 10 and
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and set up the SVG sources and Fantasticon.
2. [Configuration](configuration/index.md) — select icons, tune the settings, and
   build the font (from the UI or via Drush).

## Where it lives in the admin menu

The generate/settings form is at **Configuration → Media → Custom Bootstrap Icon
Font** (`/admin/config/media/bootstrap-icon-font`), behind the *administer custom
bootstrap icon font* permission — see [Configuration](configuration/index.md).
