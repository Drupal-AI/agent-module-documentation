<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twig Debugger adds a single admin checkbox that turns Drupal's Twig template-engine debugging on or off without hand-editing `sites/default/services.yml`.

---

The module provides one settings form at `/admin/config/development/twig-debugger` (route `twig_debugger.settings`, permission "administer twig debugger configuration") with a single "Enable Twig Debugging" checkbox stored as `twig_debugger.settings:enabled`. When you save the form with the box ticked, the module creates `sites/default/services.yml` (copied from `default.services.yml` if it does not yet exist) and rewrites the `twig.config` block so `debug: true`, `auto_reload: true`, and `cache: false`, then flushes all caches. Turning the box off deletes `sites/default/services.yml` again and flushes caches. Twig debug mode makes Drupal emit HTML comments around every template showing the theme hook, the candidate template-suggestion file names, and the actual template used — the standard way to discover which `.html.twig` to override. It ships no config schema, no default config, no plugins, no Drush commands, and no services; its only class is the settings form. Because it writes a real file under `sites/default`, the effect is site-wide and persists across requests until toggled off. It is a development convenience only and should never be left enabled in production.

---

- Turn on Twig debugging from the admin UI instead of editing `services.yml` by hand.
- Reveal `<!-- THEME HOOK -->` and `<!-- FILE NAME SUGGESTIONS -->` comments in rendered HTML.
- Discover the exact template-suggestion file names to use when overriding a template.
- See which `.html.twig` file actually rendered a given region, block, node, or field.
- Enable `auto_reload` so Twig recompiles changed templates without a manual cache clear.
- Disable Twig caching during active theme development for faster iteration.
- Let a themer without shell access flip debug mode on through the browser.
- Quickly toggle debug mode off again before deploying or handing a site back to a client.
- Bootstrap a `sites/default/services.yml` from `default.services.yml` on a site that lacks one.
- Standardise how a team enables template debugging across local environments.
- Troubleshoot why a template override is not being picked up (wrong suggestion name).
- Inspect field/entity render arrays' template selection while building a custom theme.
- Verify a preprocess hook is targeting the template you think it is.
- Teach new Drupal themers how theme-hook suggestions work by showing the comments live.
- Confirm which base theme template a subtheme is inheriting.
- Enable debugging temporarily to capture suggestion names, then disable it again.
- Avoid remembering the exact `twig.config` keys (`debug`, `auto_reload`, `cache`) to change.
- Provide a one-click way to reset Twig debug state by deleting the generated `services.yml`.
- Gate access to toggling debug mode behind a dedicated permission.
- Debug why a component/SDC or Layout Builder template is not matching expectations.
- Use during a theme migration to map old template overrides to new suggestion names.
- Flush caches automatically as part of toggling debug so changes take effect immediately.
- Keep debug configuration out of version control by managing it through the form.
- Confirm Twig debug is currently on/off by reading `twig_debugger.settings:enabled`.
