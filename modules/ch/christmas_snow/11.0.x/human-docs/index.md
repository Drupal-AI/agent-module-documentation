# Christmas Snow — manual setup guide

**Christmas Snow** (`christmas_snow`) drops a decorative animated snowfall over the
front end of your site. It bundles the glue code that hooks Scott Schiller's
*Snowstorm* JavaScript library into Drupal, so once you flip a single switch,
snowflakes drift down every visitor-facing page. It is the classic "make the site
festive for December" module — no theme work, no custom code.

Enabling the module alone does **not** start the snow. You turn it on from one
admin settings form and it stays off until you tick *Enable snow* there. The same
form lets you tune the effect: flake density, colour (with an interactive colour
picker), how deep snow piles at the bottom, and toggles for follow-the-mouse,
melt, stick, twinkle, the flake glyph, and animation smoothness. Snow is
automatically suppressed on admin pages, so it never gets in the way of editing.
The module has no dependencies beyond Drupal core.

One important caveat to know up front: the Snowstorm library is declared as an
**external asset loaded from a CDN** (`cdn.rawgit.com`) rather than bundled with
the module — and that CDN host is now defunct. On many sites the effect will not
actually appear until you point the library at a working, self-hosted copy of
Snowstorm. The [configuration](configuration/index.md) page explains this.

An optional submodule, **Christmas Snow Schedule** (`christmas_snow_schedule`),
adds date-range scheduling so the snow auto-enables and disables via cron — handy
for "only during December" without anyone remembering to switch it off.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the optional scheduling submodule.
2. [Configuration](configuration/index.md) — the settings form field by field,
   plus the dead-CDN workaround you will probably need.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Christmas Snow → Christmas
Snow settings** (`/admin/config/christmas_snow/cs_settings`). Editing it requires
the core **Administer site configuration** permission. Remember: the snow stays
off until you tick *Enable snow* on that form and save.
