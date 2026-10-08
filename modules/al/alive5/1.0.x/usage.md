Alive5 embeds the Alive5 third-party live chat widget on a Drupal site from an admin settings page, with cache-safe rules that control which pages, roles, and content types show the chat.

---

The module implements `hook_page_attachments()` and, when its display rules pass for the current request, attaches a tiny local JS loader (`js/alive5.js`) plus `drupalSettings.alive5` carrying the `widget_id` and `script_url`. The loader recreates the official Alive5 embed snippet client-side — it builds a `<script async src="{script_url}" data-widget_code_id="{widget_id}" id="a5widget">` element via `document.createElement`, guarding on the `a5widget` element ID so the vendor script is never injected twice. All behaviour is driven by the single `alive5.settings` config object edited at `/admin/config/system/alive5` (permission `administer alive5`). The `Alive5WidgetManager` service evaluates four rule groups (user visibility/role, admin route, path patterns, content type) and records the exact cache contexts each consulted, so pages vary and invalidate correctly under Page Cache, Dynamic Page Cache, and BigPipe. There is no server-side call to Alive5, no database table, and no state entry — only configuration.

---

- Add the Alive5 live chat widget to a Drupal 10/11 site without editing any theme, template, or `html.html.twig`.
- Enable/disable the whole widget with one checkbox while keeping the rest of the settings intact.
- Paste the Alive5 Widget ID from your account and have chat go live on save.
- Show the widget across the entire site.
- Restrict the widget to a hand-picked list of pages ("Selected pages only" mode).
- Show the widget everywhere except a list of pages ("All pages except the selected ones" mode).
- Target pages with Drupal path patterns, including `*` wildcards (`/blog/*`) and the `<front>` token.
- Match rules against both the URL alias and the internal system path of a request.
- Hide the widget on all administration pages (`/admin/*`), using Drupal's own admin-route definition.
- Hide the widget on user account pages (`/user`, `/user/login`, `/user/register`, …).
- Hide the widget on cart and checkout pages (`/cart`, `/checkout` — Commerce and Ubercart paths), on by default.
- Show the widget only to anonymous visitors (e.g. drive support toward prospects).
- Show the widget only to logged-in users.
- Restrict the widget to users holding one or more selected roles.
- Restrict the widget to nodes of selected content types only (appears only when core Node is installed).
- Keep chat off checkout so it never overlaps payment flows, while still showing it on marketing pages.
- Run the widget cache-safely behind Internal Page Cache / Dynamic Page Cache / BigPipe with no cache poisoning.
- Keep the JS loader eligible for aggregation (no per-file attributes) so it bundles with your other JS.
- Export and import all widget settings as code via `drush config:export` / `config:import`.
- Verify configuration state from Reports → Status report (shows Not configured / Disabled / Enabled).
- Point the loader at an alternate vendor script URL (HTTPS-only) if Alive5 support provides one.
- Cleanly uninstall — `alive5.settings` config and the module permission are removed, nothing else left behind.
- Coexist with Google Tag Manager / Google Tag without conflict.
- Pair with the Purge module so config changes invalidate a Varnish/CDN edge cache via the `config:alive5.settings` tag.
