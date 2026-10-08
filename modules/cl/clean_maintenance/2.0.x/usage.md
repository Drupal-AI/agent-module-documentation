<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Replaces Drupal's default maintenance page with a custom template so the "site under maintenance" screen looks clean and on-brand.

---
Through `hook_theme_registry_alter()` the module repoints the core `maintenance_page` theme hook at its own module `templates/` directory and swaps in its own variables — the site name and the configured maintenance message (`system.maintenance` message, tokenised with `@site`) — rendered via `FormattableMarkup`. It deliberately skips the `system.db_update` route so the update.php page keeps the standard maintenance UI.

There is no configuration form of its own: the message comes from Drupal's standard Maintenance mode settings (`/admin/config/development/maintenance`) and the site name from `system.site`. Enabling the module and putting the site into maintenance mode is the whole workflow; customise the look by overriding the module's Twig template in a theme.
---
- Show a branded maintenance page when the site is offline.
- Replace the plain default maintenance screen.
- Reuse the standard maintenance message on a nicer template.
- Keep update.php on the default maintenance UI.
- Display the site name on the maintenance page.
- Override the maintenance template from a theme.
- Present a professional "we'll be back" page.
- Maintain consistent branding during downtime.
- Avoid building a custom offline page from scratch.
- Use core Maintenance mode settings unchanged.
- Tokenise the maintenance message with the site name.
- Roll out a cleaner maintenance page site-wide by enabling one module.
- Customise maintenance markup without hacking core.
- Communicate downtime clearly to visitors.
- Pair with scheduled maintenance windows.