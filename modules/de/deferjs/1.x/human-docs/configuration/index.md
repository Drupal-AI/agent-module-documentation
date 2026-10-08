# Configuration

Defer JS is configured on a single settings page, where you control how it
defers JavaScript on your site.

## Open the settings

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Performance → Defer JS**
   (`/admin/config/performance/deferjs`).

## Tune the deferring behavior

The settings page controls the module's automated deferring of JavaScript
files — that is, having JS files hold off loading and executing until the page's
DOM has finished loading and rendering. Adjust the options to match your site's
needs and save.

The module's automation focuses on JS files. The underlying `deferjs` library
supports further capabilities — custom delays for CSS and JS, lazy‑loading of
other resources — which you can explore from the library's own documentation if
you need more than the built‑in JS deferring.

## Save and test

Click **Save configuration**. Then, importantly, load your front‑end pages and
exercise the interactive features — menus, sliders, forms, anything driven by
JavaScript. Because deferring changes *when* scripts run, occasionally a script
that depends on load order or on running early may misbehave; if you spot
something, revisit these settings. Always confirm on a staging environment before
enabling on production.
