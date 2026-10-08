Redirect stores and serves URL redirects (301/302) so old or changed paths forward visitors to the right page, and can auto-create redirects when URL aliases change.

---

Redirect provides a `redirect` content entity: each record maps a source path (with optional query string) to a destination URL and an HTTP status code (301 by default, but configurable). A request subscriber (`RedirectRequestSubscriber`) checks every incoming request against the redirect repository and issues the redirect before Drupal renders a page. Site builders manage redirects at **Admin → Configuration → Search and metadata → URL redirects**, and global behavior at the settings form: default status code, whether to retain the query string, whether to redirect on admin paths, menu access checking, and the "route normalizer" that enforces clean, canonical URLs (e.g. stripping trailing slashes or redirecting aliases to their canonical form). When the Pathauto/core alias of an entity changes, Redirect can **automatically create** a redirect from the old alias so links and SEO ranking survive. Developers get services — `redirect.repository` to look up redirects, `redirect.checker`, `redirect.prefix_list` — plus the `Redirect` entity API for creating redirects in code, and a `hook_redirect_response_alter()` to act on the response. Two submodules extend it: **Redirect 404** logs 404s and lets you turn frequent misses into redirects, and **Redirect Domain** redirects between whole domains. It is a core SEO/maintenance tool used on nearly a quarter-million sites.

---

- Redirect a retired page (`/old-page`) to its replacement with a 301.
- Preserve SEO ranking when a URL alias changes by auto-creating a redirect.
- Send an old query-string URL to a new clean path, retaining or dropping the query.
- Consolidate duplicate URLs onto one canonical path.
- Redirect `/node/123` style paths to their alias.
- Enforce trailing-slash / case normalization via the route normalizer.
- Redirect visitors from a legacy site structure after a migration.
- Bulk-import redirects from a spreadsheet during a relaunch.
- Choose 302 (temporary) for a seasonal or campaign landing page.
- Create redirects programmatically in an update hook or custom module.
- Look up whether a path already has a redirect before creating one (repository API).
- Forward marketing short URLs to full campaign pages.
- Turn frequently hit 404s into real redirects (Redirect 404 submodule).
- Log and review missing-page requests to find broken inbound links (Redirect 404).
- Let editors "ignore" specific 404s so they stop cluttering the report (Redirect 404).
- Redirect an entire old domain to a new one (Redirect Domain submodule).
- Map several parked domains to sub-paths of the main site (Redirect Domain).
- Alter the redirect response (add a message, change target) via a hook.
- Keep redirects out of admin paths, or allow them, per the settings.
- Set a site-wide default redirect status code.
- Retain the incoming query string through the redirect for tracking params.
- Deploy redirect settings as configuration between environments.
- Delete redirects in bulk from the admin list with the delete action.
- Gate who can manage redirects vs. change global settings via permissions.
- Prevent redirect loops (the module detects and blocks them).
- Redirect fielded "redirect source" values captured on content forms.
- Support multilingual redirects with per-language source matching.
