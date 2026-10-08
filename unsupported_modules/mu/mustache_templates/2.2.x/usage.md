<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mustache Logic-less Templates brings the Mustache templating language to Drupal as a text-format filter, a render element, and a token-aware rendering engine.

---

The base module wires Mustache.php (server) and Mustache.js (client) into Drupal. Its central pieces are a `mustache` text-format filter (`src/Plugin/Filter/MustacheFilter.php`) that renders Mustache syntax and Drupal tokens found in filtered text, a `Mustache` render element, helper/engine classes (`MustachePhpEngine`, loaders, PHP caches), and a `MustacheMagic` plugin type for pluggable `{{...}}` helpers (conditions, filters, translation, introspection, JS/CSS libraries, messages). A single permission, `view mustache debug messages`, controls whether debug `{{show.*}}` output is displayed.

Three submodules extend it: `mustache_token` decorates the token system, `mustache_views` exposes a Views style/integration, and `mustache_magic` adds an anonymous server endpoint `/m/sync` (`ProxySyncController`) that re-renders a stored template by a hash key. That hash is a salted `sha3-512` of the stored values combined with the site's private hash salt, and the controller runs entity `view` access checks before rendering, so the endpoint acts as an unguessable capability token, not an open template renderer. The text-format filter is only writable by users with access to a format that enables it — assign it to trusted formats, as with any powerful filter. Mustache is logic-less (no arbitrary PHP), which limits injection to token/data disclosure within the author's own access.

---
- Let editors write logic-less Mustache templates inside a text format.
- Interpolate Drupal tokens like `{{site.name}}` or `{{node.title}}` in content.
- Use Mustache conditionals/sections for simple presentational logic.
- Share the same template on the client (Mustache.js) and server (Mustache.php).
- Render dynamic snippets without writing a custom Twig template.
- Add reusable `{{...}}` helpers via the MustacheMagic plugin type.
- Attach JS/CSS libraries from within a template with Magic plugins.
- Expose Views output through the Mustache Views integration.
- Sync a rendered template to the browser via the `/m/sync` endpoint.
- Cache rendered Mustache output with the built-in PHP caches.
- Restrict debug message output with the `view mustache debug messages` permission.
- Translate strings inside templates with the translation Magic plugin.
- Build token-driven email or block bodies with a familiar syntax.
- Give non-developers a safe, logic-less way to template content.
- Introspect available data with the introspection Magic plugin.
- Assign the Mustache filter only to formats used by trusted roles.
