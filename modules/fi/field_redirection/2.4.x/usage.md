<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Redirection provides a "Redirect" field formatter that, when an entity page is viewed, sends an HTTP redirect to the URL held in a link, entity-reference, or file field — turning an entity into a redirect to somewhere else.

---

The module adds one field formatter plugin, `field_redirection_formatter` (label "Redirect"), that works on `link`, `entity_reference`, and `file` fields. When the entity is rendered (in a real web request — it deliberately no-ops under CLI/Drush), the formatter resolves the field's destination URL (a link's URL, a referenced entity's canonical URL, or a file's URL) and issues a `RedirectResponse` with a configurable HTTP status code, then `exit`s. Formatter settings are: `code` (300, 301 default, 302, 303, 304, 305, or 307), `404_if_empty` (throw a 404 when the field is empty), `page_restrictions` (0 = redirect everywhere, 1 = only on listed paths, 2 = everywhere except listed paths), and `pages` (newline-separated Drupal paths, supporting `*` wildcards, `<front>`, and tokens like `node/[node:nid]`). Logic lives in the `field_redirection.result_builder` service (`FieldRedirectionResultBuilder`) which also guards against redirect loops (it won't redirect to the current path or front page), skips during cron and maintenance mode, and honours the `bypass redirection` permission — users with that permission are not redirected and instead see a warning message with a link to where they would have gone. Because the redirect fires on view, the maintainers warn it should only be attached to the **Full content** view mode (a warning is shown otherwise). It ships a config schema for its settings and requires no modules beyond core (the settings form's token tree link is nicer with the contrib Token module, but is not a hard dependency).

---

- Turn a "redirect" content type into a 301 to an external URL stored in a link field.
- Point an entity-reference field at another node and redirect the entity's page there.
- Redirect a node to a file's download URL held in a file field.
- Send legacy landing pages to their new home with a permanent (301) redirect.
- Use a 302 temporary redirect for a campaign node that will change target later.
- Return a 404 for entities whose redirect (link) field is left empty via `404_if_empty`.
- Let editors set a per-node redirect destination without touching the redirect module.
- Restrict redirection to only certain paths using the "only on the following pages" option.
- Redirect everywhere except a set of paths (e.g. keep the edit form reachable).
- Use tokens (`node/[node:nid]`) in the page-restriction list to scope redirects dynamically.
- Give admins a `bypass redirection` permission so they can see and edit the source entity.
- Show editors a "this page redirects to …" warning instead of bouncing them.
- Build a simple link-shortener content type whose nodes 301 to long URLs.
- Redirect a taxonomy term or user page to an external profile via a link field.
- Wildcard-match paths (`blog/*`) to control where a redirect applies.
- Point a "primary link" reference field so the entity forwards to the referenced page.
- Avoid custom controller code just to redirect an entity to a field value.
- Redirect a product node to an external store page held in a link field.
- Use the front-page-loop guard so a redirect to `<front>` on the front page is skipped.
- Keep redirects from firing during cron runs and maintenance mode automatically.
- Configure the exact HTTP status (300–307) an SEO strategy requires per field.
- Attach the formatter only to the Full content view mode as recommended.
- Redirect an event node to a registration URL stored on the event.
- Forward a "see also" reference field to the canonical entity it points at.
