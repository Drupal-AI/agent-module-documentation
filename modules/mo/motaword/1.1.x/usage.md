MotaWord localizes a Drupal site into 100+ languages through MotaWord Active Serve — a CDN-backed dynamic translation layer — with no duplicate content trees in Drupal.

---

MotaWord connects a Drupal site to a MotaWord Active project using a single Active token. Once the token is saved, the module fetches the project and widget metadata from Active Serve and offers two translation modes: a browser-side mode that injects the ActiveJS widget script so text is swapped in the visitor's browser, and a server-side proxy mode that intercepts locale-prefixed URLs (e.g. `/fr/about`) and returns pre-translated HTML fetched from Serve's CDN — better for SEO because search engines see fully translated markup. The bundled ActiveJS widget provides an in-page language picker, or you can build your own switcher using the `localize-page-as-<locale>`, `localize-as-<locale>`, and `nolocalize` link classes, which the module rewrites server-side (for first paint and SEO) and ActiveJS honours client-side. Saving any node, term, menu, block, or theme change purges the matching URLs from Serve's cache so translations stay fresh, and a dashboard callback lets MotaWord push project changes to the site without admin action. Metadata is stored per environment in the State API (never in exported config), the token can be pinned per environment from `settings.php`, and a config-import guard keeps deploys from resetting a configured site. Every call to Serve fails open: if MotaWord is unreachable the original page is served unchanged. Administration is gated by the `administer motaword` permission and the module runs on Drupal 9, 10, and 11.

---

- Translate a Drupal site into 100+ languages without maintaining per-language content in Drupal.
- Serve pre-translated HTML from MotaWord's global CDN at locale-prefixed URLs like `/fr/about` or `/es-MX/blog/post`.
- Choose browser-side translation (ActiveJS widget) for quick setup on most sites.
- Choose server-side proxy translation for better SEO (search engines see translated markup).
- Inject the MotaWord in-page language picker widget on every front-end page.
- Give site administrators an admin-only preview mode before translations go live to visitors.
- Build a custom language switcher with `localize-page-as-<locale>` links that point to the current page in another locale.
- Localize an individual link's own destination with `localize-as-<locale>`.
- Exclude specific links or menu items from translation with `nolocalize`.
- Rewrite custom-switcher menu links server-side so they work on first paint without JavaScript.
- Keep translations current automatically — editing nodes, terms, menus, blocks, or the theme purges the affected Serve cache entries.
- Re-crawl the domain into the target locales after site-wide changes (theme switch, menu edit, block placement).
- Exclude paths such as `/cart` or `/checkout` from translation via a URL blacklist.
- Redirect authenticated Drupal users off locale URLs so they keep Drupal's personalized chrome.
- Receive dashboard callbacks so MotaWord project/widget changes sync to the site with no admin action.
- Pin the Active token per environment from `settings.php` (e.g. from an environment variable) to keep it out of exported config.
- Deploy across dev/staging/production without `drush cim` / `drush deploy` resetting saved MotaWord settings or blanking a saved token.
- Run on multisite installs where each site keeps its own MotaWord configuration.
- Clear the entire domain's Active translation cache from the settings page on demand.
- Refresh project and widget metadata from the settings page without re-saving the form.
- Filter module activity in the log with `drush watchdog:show --type=motaword`.
- Keep the site fully functional during a MotaWord outage — every Serve call fails open to the original page.
- Prevent the admin toolbar and admin routes from being translated so admin workflows stay intact.
- Pair with the separate `tmgmt_motaword` module when you also need one-off human-translation jobs for specific pages.
